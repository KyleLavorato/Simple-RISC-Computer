// Testbench for the main datapath
module computer_tb;

// Testing Counters
reg [31:0] cycle;
reg [31:0] test;

wire clkOut;
wire [31:0] busDataOut;
// Output Signals
wire [31:0] r0_test, r1_test, r2_test, r3_test, r4_test, r5_test, r6_test, r7_test, r8_test, r9_test, 
	r10_test, r11_test, r12_test, r13_test, r14_test, r15_test, HI_test, LO_test, PC_test, Zhigh_test, 
	Zlow_test, Y_test, IR_test;
// Special Signals
reg clr, PCinc_en, MDRread;
// Enable Signals
reg r0In, r1In, r2In, r3In, r4In, r5In, r6In, r7In, r8In, r9In, r10In, r11In,
	r12In, r13In, r14In, r15In, HIIn, LOIn, PCIn, IRIn, MARIn, MDRIn, Y_en, Z_en;
// Output Signals (Encoder Input)
reg r0Out, r1Out, r2Out, r3Out, r4Out, r5Out, r6Out, r7Out, r8Out, r9Out, r10Out, r11Out,
	r12Out, r13Out, r14Out, r15Out, HIOut, LOOut, PCOut, IROut, MAROut, MDROut, InPortOut,
	Zlow_en, Zhigh_en;
reg [4:0] opcode;
reg [31:0] busDataIn;


computer cp(clkOut,
	//busDataOut,
	r0_test, r1_test, r2_test, r3_test, r4_test, r5_test, r6_test, r7_test, r8_test, 
		r9_test, r10_test, r11_test, r12_test, r13_test, r14_test, r15_test, HI_test, 
		LO_test, PC_test, Zhigh_test, Zlow_test, Y_test, IR_test, busDataOut, 
	clr, PCinc_en, MDRread, Y_en, Z_en, Zlow_en, Zhigh_en,
	r0In, r1In, r2In, r3In, r4In, r5In, r6In, r7In, r8In, r9In, r10In, r11In,
		r12In, r13In, r14In, r15In, HIIn, LOIn, PCIn, IRIn, MARIn, MDRIn,
	r0Out, r1Out, r2Out, r3Out, r4Out, r5Out, r6Out, r7Out, r8Out, r9Out, r10Out, r11Out,
		r12Out, r13Out, r14Out, r15Out, HIOut, LOOut, PCOut, IROut, MAROut, MDROut, InPortOut,
	opcode,
	busDataIn
);

initial begin
	clr <= 1;
	#100
	setControlLow;
	#100
	adderTest;
	subTest;
	multTest;
	divTest;
	andTest;
	orTest;
	shrTest;
	shlTest;
	rorTest;
	rolTest;
	negTest;
	notTest;
end
	
// Set all control signals that are an input to the datapath to low
task setControlLow; begin
	// Enable Signals
	r0In <= 0; r1In <= 0; r2In <= 0; r3In <= 0; r4In <= 0; r5In <= 0; r6In <= 0; 
		r7In <= 0; r8In <= 0; r9In <= 0; r10In <= 0; r11In <= 0; r12In <= 0; r13In <= 0; 
		r14In <= 0; r15In <= 0; HIIn <= 0; LOIn <= 0; PCIn <= 0; IRIn <= 0; MARIn <= 0; 
		MDRIn <= 0; Z_en <= 0; Y_en <= 0;
	// Output Signals
	r0Out <= 0; r1Out <= 0; r2Out <= 0; r3Out <= 0; r4Out <= 0; r5Out <= 0; r6Out <= 0; 
		r7Out <= 0; r8Out <= 0; r9Out <= 0; r10Out <= 0; r11Out <= 0; r12Out <= 0; 
		r13Out <= 0; r14Out <= 0; r15Out <= 0; HIOut <= 0; LOOut <= 0; PCOut <= 0; 
		IROut <= 0; MAROut <= 0; MDROut <= 0; InPortOut <= 0; Zlow_en <= 0; Zhigh_en <= 0;
	// Special Control Signals
	clr <= 0; PCinc_en <= 0; MDRread <= 0;
	opcode <= 5'b00000;
	busDataIn <= 32'bzzzzzzzz_zzzzzzzz_zzzzzzzz_zzzzzzzz;
end
endtask

task adderTest; begin
	// add R1, R2, R3
	#100
	test <= 1;
	// Set R2 Value
	cycle <= -2; setControlLow; busDataIn <= 25; InPortOut <= 1; r2In <= 1;
	#100
	// Set R3 Value
	cycle <= -1; setControlLow; busDataIn <= 10; InPortOut <= 1; r3In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r2Out <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; r3Out <= 1; opcode <= 5'b001001; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; r1In <= 1;
	#100;
end
endtask

task subTest; begin
	// sub R0, R4, R5
	#100
	test <= 2;
	// Set R4 Value
	cycle <= -2; setControlLow; busDataIn <= 25; InPortOut <= 1; r4In <= 1;
	#100
	// Set R5 Value
	cycle <= -1; setControlLow; busDataIn <= 10; InPortOut <= 1; r5In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r4Out <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; r5Out <= 1; opcode <= 5'b00110; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; r0In <= 1;
	#100;
end
endtask

task multTest; begin
	// mul R5, R7
	#100
	test <= 3;
	// Set R5 Value
	cycle <= -2; setControlLow; busDataIn <= 5; InPortOut <= 1; r5In <= 1;
	#100
	// Set R7 Value
	cycle <= -1; setControlLow; busDataIn <= 10; InPortOut <= 1; r7In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r5Out <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; r7Out <= 1; opcode <= 5'b10001; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; LOIn <= 1;
	#100
	// T6
	cycle <= 6; setControlLow; Zhigh_en <= 1; HIIn <= 1;
	#100;
end
endtask

task divTest; begin
	// div R3, R1
	#100
	test <= 4;
	// Set R3 Value
	cycle <= -2; setControlLow; busDataIn <= 32; InPortOut <= 1; r3In <= 1;
	#100
	// Set R1 Value
	cycle <= -1; setControlLow; busDataIn <= 5; InPortOut <= 1; r1In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r3Out <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; r1Out <= 1; opcode <= 5'b10010; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; LOIn <= 1;
	#100
	// T6
	cycle <= 6; setControlLow; Zhigh_en <= 1; HIIn <= 1;
	#100;
end
endtask

task andTest; begin
	// and R2, R3, R6
	#100
	test <= 5;
	// Set R3 Value
	cycle <= -2; setControlLow; busDataIn <= 25; InPortOut <= 1; r3In <= 1;
	#100
	// Set R6 Value
	cycle <= -1; setControlLow; busDataIn <= 10; InPortOut <= 1; r6In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r3Out <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; r6Out <= 1; opcode <= 5'b00111; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; r2In <= 1;
	#100;
end
endtask

task orTest; begin
	// or R0, R1, R7
	#100
	test <= 6;
	// Set R1 Value
	cycle <= -2; setControlLow; busDataIn <= 25; InPortOut <= 1; r1In <= 1;
	#100
	// Set R7 Value
	cycle <= -1; setControlLow; busDataIn <= 10; InPortOut <= 1; r7In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r1Out <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; r7Out <= 1; opcode <= 5'b01000; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; r0In <= 1;
	#100;
end
endtask

task shrTest; begin
	// shr R2, R1, R3
	#100
	test <= 7;
	// Set R1 Value
	cycle <= -2; setControlLow; busDataIn <= 32; InPortOut <= 1; r1In <= 1;
	#100
	// Set R3 Value
	cycle <= -1; setControlLow; busDataIn <= 2; InPortOut <= 1; r3In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r1Out <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; r3Out <= 1; opcode <= 5'b01001; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; r2In <= 1;
	#100;
end
endtask

task shlTest; begin
	// shl R3, R0, R5
	#100
	test <= 8;
	// Set R0 Value
	cycle <= -2; setControlLow; busDataIn <= -32; InPortOut <= 1; r0In <= 1;
	#100
	// Set R5 Value
	cycle <= -1; setControlLow; busDataIn <= 2; InPortOut <= 1; r5In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r0Out <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; r5Out <= 1; opcode <= 5'b01011; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; r3In <= 1;
	#100;
end
endtask

task rorTest; begin
	// ror R1, R1, R2
	#100
	test <= 9;
	// Set R1 Value
	cycle <= -2; setControlLow; busDataIn <= 'hD; InPortOut <= 1; r1In <= 1;
	#100
	// Set R2 Value
	cycle <= -1; setControlLow; busDataIn <= 4; InPortOut <= 1; r2In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r1Out <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; r2Out <= 1; opcode <= 5'b01100; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; r1In <= 1;
	#100;
end
endtask

task rolTest; begin
	// ror R0, R0, R4
	#100
	test <= 10;
	// Set R0 Value
	cycle <= -2; setControlLow; busDataIn <= 'hD000_0000; InPortOut <= 1; r0In <= 1;
	#100
	// Set R4 Value
	cycle <= -1; setControlLow; busDataIn <= 4; InPortOut <= 1; r4In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r0Out <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; r4Out <= 1; opcode <= 5'b01101; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; r0In <= 1;
	#100;
end
endtask

task negTest; begin
	// neg R1, R2
	#100
	test <= 11;
	// Set R2 Value
	cycle <= -1; setControlLow; busDataIn <= 5; InPortOut <= 1; r2In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r2Out <= 1; opcode <= 5'b10011; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; r1In <= 1;
	#100;
end
endtask

task notTest; begin
	// not R1, R2
	#100
	test <= 12;
	// Set R2 Value
	cycle <= -1; setControlLow; busDataIn <= 5; InPortOut <= 1; r2In <= 1;
	#100
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; MDRread <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; r2Out <= 1; opcode <= 5'b10100; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; r1In <= 1;
	#100;
end
endtask

endmodule
