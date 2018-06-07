// Datapath for the computer system
module computer(
	input wire reset,
	input wire [31:0]InPort_dataIn
);

wire[4:0] opcode;

// Select and Encode Signals
wire Rin, Rout, Gra, Grb, Grc;

// Special Enable Signals
wire HIIn, LOIn, conIn, PCIn, IRIn, Y_en, Z_en, MARIn, MDRIn, outPortIn;

// Special Output Signals
wire cOut, InPortOut, BAout, PCOut, MDROut, Zhigh_en, Zlow_en, HIOut, LOOut;

wire PCinc_en;

wire mread_en, mwrite_en, sread_en, swrite_en, run, clr;

wire stop;

wire clk;
Clock clkInstance(clk);
assign clkOut = clk;

// Bus data
wire [31:0] busmux_out;

// Output signals for the I/O ports
wire[31:0] InPort_out, outPort_out;

// Wire for the RAM address
wire [8:0] mem_address;

// Input to the Z register (ALU output)
wire [63:0] Z_in; 

// Register output
wire [31:0] r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, r9_out, r10_out, r11_out, 
r12_out, r13_out, r14_out, r15_out, HI_out, LO_out, PC_out, IR_out, Y_out, Zhigh_out, Zlow_out, MDR_out, C_out;

// Enable Signals
wire r0In, r1In, r2In, r3In, r4In, r5In, r6In, r7In, r8In, r9In, r10In, r11In, r12In, r13In, r14In, r15In;

// Output Signals (Encoder Input)
wire r0Out, r1Out, r2Out, r3Out, r4Out, r5Out, r6Out, r7Out, r8Out, r9Out, r10Out, r11Out, r12Out, r13Out, r14Out, r15Out;

// Bus-Encoder select signal
wire [4:0] select;

// Standard 16 Registers
regR0 R0(r0_out, busmux_out, r0In, clk, clr, BAout);
reg32 R1(r1_out, busmux_out, r1In, clk, clr);
reg32 R2(r2_out, busmux_out, r2In, clk, clr);
reg32 R3(r3_out, busmux_out, r3In, clk, clr);
reg32 R4(r4_out, busmux_out, r4In, clk, clr);
reg32 R5(r5_out, busmux_out, r5In, clk, clr);
reg32 R6(r6_out, busmux_out, r6In, clk, clr);
reg32 R7(r7_out, busmux_out, r7In, clk, clr);
reg32 R8(r8_out, busmux_out, r8In, clk, clr);
reg32 R9(r9_out, busmux_out, r9In, clk, clr);
reg32 R10(r10_out, busmux_out, r10In, clk, clr);
reg32 R11(r11_out, busmux_out, r11In, clk, clr);
reg32 R12(r12_out, busmux_out, r12In, clk, clr);
reg32 R13(r13_out, busmux_out, r13In, clk, clr);
reg32 R14(r14_out, busmux_out, r14In, clk, clr);
reg32 R15(r15_out, busmux_out, r15In, clk, clr);

// Internal Registers
reg32 HI(HI_out, busmux_out, HIIn, clk, clr);
reg32 LO(LO_out, busmux_out, LOIn, clk, clr);
reg32 PC(PC_out, busmux_out, PCIn, clk, clr);
reg32 IR(IR_out, busmux_out, IRIn, clk, clr);
reg32 Y(Y_out, busmux_out, Y_en, clk, clr);
reg64 Z(Zhigh_out, Zlow_out, Z_in, Z_en, clk, clr, Zlow_en, Zhigh_en);

encoder encoder1(select,
	r0Out, r1Out, r2Out, r3Out, r4Out, r5Out, r6Out, r7Out, r8Out, r9Out, r10Out, r11Out,
	r12Out, r13Out, r14Out, r15Out, HIOut, LOOut, PCOut, MDROut, InPortOut, Zhigh_en, Zlow_en, cOut 
);

Bus32 bus1(busmux_out, 
	r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, r9_out, r10_out, r11_out, r12_out, r13_out, r14_out, 
	r15_out, HI_out, LO_out, PC_out, MDR_out, InPort_out, Zhigh_out, Zlow_out, C_out,
	select
);

alu alu1(Z_in,
Y_out, busmux_out, opcode, PCinc_en);

// Phase 2

reg32 MAR(mem_address, busmux_out, MARIn, clk, clr);

wire [31:0] Mdatain, Sdatain, mem_data;
wire mdr_read;
assign mdr_read = mread_en | sread_en;
assign mem_data = Mdatain | Sdatain;  // M/S(datain) is 0 when not in use
mdr MDR(MDR_out, mem_data, busmux_out, MDRIn, clk, clr, mdr_read);

ram512 dodgeram(Mdatain, MDR_out, mem_address, mread_en, mwrite_en);
stack32 stack(Sdatain, MDR_out, sread_en, swrite_en);

selectAndEncode encode(C_out, 
	r0In, r1In, r2In, r3In, r4In, r5In, r6In, r7In, r8In, r9In, r10In, r11In, r12In, r13In, r14In, r15In,
	r0Out, r1Out, r2Out, r3Out, r4Out, r5Out, r6Out, r7Out, r8Out, r9Out, r10Out, r11Out, r12Out, r13Out, r14Out, r15Out, 
	IR_out,
	Gra, Grb, Grc, Rin, Rout, BAout
);

conFF compare(conFF_Out, busmux_out, IR_out[1:0], clk, conIn);

inPort port1(InPort_out, InPort_dataIn, clr, clk);
outPort port2(outPort_out, busmux_out, clr, clk, outPortIn);

// Phase 3


ControlUnit cu(
	Rin, Rout, Gra, Grb, Grc,
	HIIn, LOIn, conIn, PCIn, IRIn, Y_en, Z_en, MARIn, MDRIn, outPortIn, cOut, InPortOut, BAout,
	PCOut, MDROut, Zhigh_en, Zlow_en, HIOut, LOOut,
	PCinc_en,
	opcode,
	mread_en, mwrite_en, sread_en, swrite_en, run, clr,
	stateOut,
	clk, reset, stop, conFF_Out,
	IR_out
);

endmodule
