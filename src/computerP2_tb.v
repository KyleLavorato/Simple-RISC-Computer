// Testbench for the main datapath
module computerP2_tb;

// Testing Counters
reg [31:0] cycle;
reg [31:0] test;

// Output signals
wire clkOut, conFF_Out;
wire [31:0] busDataOut;
wire [31:0] PC_test, IR_test, MAR_test, MDR_test, cSign_test, outPort_test, r0_test, r1_test, r2_test, r3_test, r4_test, r5_test, r6_test, r7_test, r8_test, r9_test, 
	r10_test, r11_test, r12_test, r13_test, r14_test, r15_test, HI_test, LO_test, Zhigh_test, 
	Zlow_test, Y_test;
	
// Special Signals
reg clr, PCinc_en, read, write;

// Enable Signals
reg HIIn, LOIn, PCIn, IRIn, MARIn, MDRIn, conIn, outPortIn, Y_en, Z_en;

// Output Signals (Encoder Input)
reg HIOut, LOOut, PCOut, IROut, MAROut, MDROut, InPortOut, cOut, Zlow_en, Zhigh_en;

// Select and Encode signals
reg Gra, Grb, Grc, Rin, Rout, BAout;
reg [4:0] opcode;
reg [31:0] busDataIn;

computer cp(clkOut, conFF_Out,
	MAR_test, MDR_test, outPort_test, cSign_test, r0_test, r1_test, r2_test, r3_test, r4_test, r5_test, 
		r6_test, r7_test, r8_test, r9_test, r10_test, r11_test, r12_test, r13_test, r14_test, 
		r15_test, HI_test, LO_test, PC_test, Zhigh_test, Zlow_test, Y_test, IR_test, busDataOut, 
	clr, PCinc_en, read, write, Y_en, Z_en, Zlow_en, Zhigh_en, 
	HIIn, LOIn, PCIn, IRIn, MARIn, MDRIn, conIn, outPortIn,
	HIOut, LOOut, PCOut, IROut, MAROut, MDROut, InPortOut, cOut,
	Gra, Grb, Grc, Rin, Rout, BAout,
	opcode,
	busDataIn
);

initial begin
	setControlLow;
	clr <= 1;
	#99  // Offset to prevent register update delay
	setControlLow;
	#100
	setPC(20);  // Set initial PC to addresses in RAM with values
	initRAM;
	ldTest;
	stTest;
	aluTest;
	brTest;
	jumpTest;
	mfTest;
	portTest;
end
	
	
// Set all control signals that are an input to the datapath to low
task setControlLow; begin
	// Enable Signals
	HIIn <= 0; LOIn <= 0; PCIn <= 0; IRIn <= 0; MARIn <= 0; MDRIn <= 0; Z_en <= 0; Y_en <= 0;
	conIn <= 0; outPortIn <= 0;
	// Output Signals
	HIOut <= 0; LOOut <= 0; PCOut <= 0; IROut <= 0; MAROut <= 0; MDROut <= 0; InPortOut <= 0; 
		Zlow_en <= 0; Zhigh_en <= 0; cOut <= 0;
	// Special Control Signals
	clr <= 0; PCinc_en <= 0; read <= 0; write <= 0;
	Gra <= 0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0; BAout <= 0;
	opcode <= 5'b00000;
	busDataIn <= 32'bzzzzzzzz_zzzzzzzz_zzzzzzzz_zzzzzzzz;
end
endtask


// Set values to specific addresses in RAM manually
task initRAM; begin
	// Data For PC to Load
	setRAM(20, 10);
	setRAM(21, 11);
	setRAM(22, 12);
	setRAM(23, 13);
	setRAM(24, 14);
	setRAM(25, 15);
	setRAM(26, 16);
	setRAM(27, 17);
	setRAM(28, 18);
	setRAM(29, 19);
	setRAM(30, 20);
	setRAM(31, 21);
	setRAM(32, 22);
	setRAM(33, 23);
	setRAM(34, 24);
	setRAM(35, 25);
	// Data for tests
	setRAM(60, 200);
	setRAM(65, 5);
	setRAM(90, 120);
end
endtask


// Task to set an address in RAM to a specific value [(Address, Value)]
task setRAM;
	input[9:0] address;
	input[31:0] value;
	begin
	setControlLow; busDataIn <= value; InPortOut <= 1; MDRIn <= 1;
	#100
	setControlLow; busDataIn <= address; InPortOut <= 1; MARIn <= 1; 
	#100
	setControlLow; write <= 1;
	#100;
	end
endtask


// Task to set a register to a specific value [(Reg#, Value)]
task setReg;
	input[3:0] register;
	input[31:0] value;
	begin
	setControlLow; busDataIn <= 0; busDataIn[26:23] <= register; InPortOut <= 1; IRIn <= 1;
	#100
	setControlLow; busDataIn <= value; InPortOut <= 1; Gra <= 1; Rin <= 1;
	#100;
	end
endtask


// Task to set the PC to a specific value [(Value)]
task setPC; 
	input[31:0] value;
	begin
	setControlLow; busDataIn <= value; InPortOut <= 1; PCIn <= 1;
	#100;
	end
endtask


// Task to perform the Instruction Fetch operation (Cycles 0-2)
task instructionFetch; begin
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; read <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; //IRIn <= 1;
	#100;
end
endtask


///////////
// TESTS //
///////////

// Test the 5 specified load cases
task ldTest; begin
	// ld R1, $65
		#100
		test <= 1;
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0001_0000_0000000000001000001; InPortOut <= 1; IRIn <= 1;
		#100
		ldInstruction;
		
	// ld R0, $55(R1)
		#100
		test <= 2;
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0000_0001_0000000000000110111; InPortOut <= 1; IRIn <= 1;
		#100
		ldInstruction;
		
	// ldi R1, $65
		#100
		test <= 3;
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0001_0000_0000000000001000001; InPortOut <= 1; IRIn <= 1;
		#100
		ldiInstruction;
		
	// ldi R1, $55(R1)
		#100
		test <= 4;
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0001_0001_0000000000000110111; InPortOut <= 1; IRIn <= 1;
		#100
		ldiInstruction;
	
	// ldr R0, $65
		#100
		test <= 5;
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0000_0000_0000000000001000001; InPortOut <= 1; IRIn <= 1;
		#100
		ldrInstruction;
end
endtask


// Test the 3 specified store cases
task stTest; begin
	// st $90, R4
		#100
		test <= 6;
		cycle <= -2; setReg(4,15);
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0100_0000_0000000000001011010; InPortOut <= 1; IRIn <= 1;
		#100
		stInstruction;
	// ld R5, $90
		#100
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0101_0000_0000000000001011010; InPortOut <= 1; IRIn <= 1;
		#100
		ldInstruction;
		
	// st $90(R4), R4
		#100
		test <= 7;
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0100_0100_0000000000001011010; InPortOut <= 1; IRIn <= 1;
		#100
		stInstruction;
	// ld r3, $105
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0011_0000_0000000000001101001; InPortOut <= 1; IRIn <= 1;
		#100
		ldInstruction;
		
	// str $90, R4
		#100
		test <= 8;
		cycle <= -2; setReg(4,25);  // Change register so changes can be seen
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0100_0100_0000000000001011010; InPortOut <= 1; IRIn <= 1;
		#100
		strInstruction;
	// ld r6, $120
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0110_0000_0000000000001111000; InPortOut <= 1; IRIn <= 1;
		#100
		ldInstruction;
end
endtask


// Test the new 3 ALU instructions
task aluTest; begin
	// addi R2, R3, $25
		#100
		test <= 9;
		cycle <= -2; setReg(3,100);
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0010_0011_0000000000000011001; InPortOut <= 1; IRIn <= 1;
		#100
		aluInstruction(9);
		
	// andi R2, R3, $25
		#100
		test <= 10;
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0010_0011_0000000000000011001; InPortOut <= 1; IRIn <= 1;
		#100
		aluInstruction(7);
		
	// ori R2, R3, $25
		#100
		test <= 11;
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0010_0011_0000000000000011001; InPortOut <= 1; IRIn <= 1;
		#100
		aluInstruction(8);
end
endtask


// Test the new 4 branch instructions
task brTest; begin
	// brzr R6, R5
		#100
		test <= 12;
		cycle <= -4; setPC(20);
		cycle <= -3; setReg(6, 0);  // Branch will be taken
		cycle <= -2; setReg(5, 25);  // Will branch to 25
		// Load IR with register selection and comparison type
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0110_0101_0000000000000000000; InPortOut <= 1; IRIn <= 1;
		#100
		brInstruction;
		
	// brnz R6, R5
		#100
		test <= 13;
		cycle <= -2; setPC(20);  // Reset PC; Use same registers so branch will not be taken
		// Load IR with register selection and comparison type
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0110_0101_0000000000000000001; InPortOut <= 1; IRIn <= 1;
		#100
		brInstruction;
		
	// brmi R6, R5
		#100
		test <= 14;
		cycle <= -2; setReg(6, -30);  // Set reg to a negative value to take branch
		// Load IR with register selection and comparison type
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0110_0101_0000000000000000011; InPortOut <= 1; IRIn <= 1;
		#100
		brInstruction;
		
	// brpl R6, R5
		#100
		test <= 15;
		cycle <= -2; setPC(20);  // Reset PC; Use same registers so branch will not be taken
		// Load IR with register selection and comparison type
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0110_0101_0000000000000000010; InPortOut <= 1; IRIn <= 1;
		#100
		brInstruction;
end
endtask


// Test the new 2 new jump instructions
task jumpTest; begin
	// jr R2
		#100
		test <= 16;
		cycle <= -2; setReg(2, 30);
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0010_0000_0000000000000000000; InPortOut <= 1; IRIn <= 1;
		#100
		jumpInstruction;
		
	// jal R2
		#100
		test <= 17;
		cycle <= -2; setPC(20);
		// Load IR with register selection (IR loaded with Rb = R14 and Cout = 4 to add 4 to PC)
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0010_1110_0000000000000000100; InPortOut <= 1; IRIn <= 1;
		#100
		jalInstruction;
end
endtask


// Test the new 2 new move from instructions
task mfTest; begin
	// mfhi R4
		#100
		test <= 18;
		// Load the HI register with 300
		cycle <= -2; setControlLow; busDataIn <= 300; InPortOut <= 1; HIIn <= 1;
		#100
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0100_0000_0000000000000000000; InPortOut <= 1; IRIn <= 1;
		#100
		mfhiInstruction;
		
	// mflo R6
		#100
		test <= 19;
		// Load the LO register with 500
		cycle <= -2; setControlLow; busDataIn <= 500; InPortOut <= 1; LOIn <= 1;
		#100
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0110_0000_0000000000000000000; InPortOut <= 1; IRIn <= 1;
		#100
		mfloInstruction;
end
endtask


// Test the new 2 new inPort and outPort instructions
task portTest; begin
	// out R2
		#100
		test <= 20;
		cycle <= -2; setReg(2, 80);
		#100
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0010_0000_0000000000000000000; InPortOut <= 1; IRIn <= 1;
		#100
		outportInstruction;
		
	// in R3
		#100
		test <= 21;
		// Load IR with register selection
		cycle <= -1; setControlLow; busDataIn <= 32'b00000_0011_0000_0000000000000000000; InPortOut <= 1; IRIn <= 1;
		#100
		inportInstruction;
end
endtask

/////////////////////////
// Control Signal Sets //
/////////////////////////

// Control signal sequence for the ld instruction; Loads the value at the 
// specified address into the indicated register
task ldInstruction; begin
	// T0 - T2
	instructionFetch;
	// T3
	cycle <= 3; setControlLow; BAout <= 1; Grb <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; cOut <= 1; opcode <= 5'b001001; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; MARIn <= 1;
	#100
	// T6
	cycle <= 6; setControlLow; read <= 1; MDRIn <= 1;
	#100
	// T7
	cycle <= 7; setControlLow; MDROut <= 1; Gra <= 1; Rin <= 1;
	#100;
end
endtask


// Control signal sequence for the ldi instruction; Loads the immediate 
// value into the specified register
task ldiInstruction; begin
	// T0 - T2
	instructionFetch;  
	// T3
	cycle <= 3; setControlLow; BAout <= 1; Grb <= 1;  Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; cOut <= 1; opcode <= 5'b001001; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; Gra <= 1; Rin <= 1;
	#100;
end
endtask


// Control signal sequence for the ldr instruction; Loads the value of RAM 
// into the register, calculating the address relative to PC
task ldrInstruction; begin
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; Y_en <= 1; read <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; //IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; cOut <= 1; opcode <= 5'b001001; Z_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; Zlow_en <= 1; MARIn <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; read <= 1; MDRIn <= 1;
	#100
	// T6
	cycle <= 6; setControlLow; MDROut <= 1; Gra <= 1; Rin <= 1;
	#100;
end
endtask


// Control signal sequence for the st instruction; Stores the indicated
// register's value in RAM at the specified address
task stInstruction; begin
	// T0 - T2
	instructionFetch;
	// T3
	cycle <= 3; setControlLow; BAout <= 1; Grb <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; cOut <= 1; opcode <= 5'b001001; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; MARIn <= 1;
	#100
	// T6
	cycle <= 6; setControlLow; Gra <= 1; Rout <= 1; MDRIn <= 1;
	#100
	// T7
	cycle <= 7; setControlLow; write <= 1;
	#100;
end
endtask


// Control signal sequence for the ldr instruction; Stores the indicated
// register's value in RAM, calculating the address relative to PC
task strInstruction; begin
	// T0
	cycle <= 0; setControlLow; PCOut <= 1; MARIn <= 1; PCinc_en <= 1; Z_en <= 1;
	#100
	// T1
	cycle <= 1; setControlLow; Zlow_en <= 1; PCIn <= 1; Y_en <= 1; read <= 1; MDRIn <= 1;
	#100
	// T2
	cycle <= 2; setControlLow; MDROut <= 1; //IRIn <= 1;
	#100
	// T3
	cycle <= 3; setControlLow; cOut <= 1; opcode <= 5'b001001; Z_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; Zlow_en <= 1; MARIn <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Gra <= 1; Rout <= 1; MDRIn <= 1;
	#100
	// T6
	cycle <= 6; setControlLow; write <= 1;
	#100;
end
endtask


// Control signal sequence for the ALU instructions, where the opcode
// is the input parameter [(opcode)]; Performs the addi, andi and ori instructions
task aluInstruction; 
	input[4:0] opcodeIn;
	begin
	// T0 - T2
	instructionFetch;
	// T3
	cycle <= 3; setControlLow; Grb <= 1; Rout <= 1; Y_en <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; cOut <= 1; opcode <= opcodeIn; Z_en <= 1;
	#100
	// T5
	cycle <= 5; setControlLow; Zlow_en <= 1; Gra <= 1; Rin <= 1;
	#100;
	end
endtask


// Control signal sequence for the branch instructions; The branch
// instruction that runs is dependent on the first two bits of the IR
// Instruction changes the PC value to that of the specified register
// if the branch condition is met
task brInstruction; begin
	// T0 - T2
	instructionFetch;
	// T3
	cycle <= 3; setControlLow; Gra <= 1; Rout <= 1; conIn <= 1;
	#100
	// T4
	cycle <= 4; setControlLow; Grb <= 1; Rout <= 1; 
	if(conFF_Out == 1) begin
		PCIn <= 1;
	end
	#100;
end
endtask


// Control signal sequence for the jp instruction; Sets the value
// of the PC to that of the indicated register
task jumpInstruction; begin 
	// T0 - T2
	instructionFetch;
	// T3
	cycle <= 3; setControlLow; Gra <= 1; Rout <= 1; PCIn <= 1;
	#100;
end
endtask


// Control signal sequence for the jal instruction; Sets the value
// of R14 to the value of the PC + 4. Then sets the value of the PC
// to that of the indicated register
task jalInstruction; begin
	// T0 - T2
	instructionFetch;
	// T3
	cycle <= 3; setControlLow; PCOut <= 1; Y_en <= 1;
	#100
	cycle <= 4; setControlLow; cOut <= 1; opcode <= 5'b001001; Z_en <= 1;
	#100
	cycle <= 5; setControlLow; Zlow_en <= 1; Grb <= 1; Rin <= 1;
	#100
	cycle <= 6; setControlLow; Gra <= 1; Rout <= 1; PCIn <= 1; 
	#100;
end
endtask


// Control signal sequence for the mfhi instruction; Copies the value
// of the HI register into the specified general purpose register
task mfhiInstruction; begin
	// T0 - T2
	instructionFetch;
	// T3
	cycle <= 3; setControlLow; HIOut <= 1; Gra <= 1; Rin <= 1;
	#100;
end
endtask


// Control signal sequence for the mflo instruction; Copies the value
// of the LO register into the specified general purpose register
task mfloInstruction; begin
	// T0 - T2
	instructionFetch;
	// T3
	cycle <= 3; setControlLow; LOOut <= 1; Gra <= 1; Rin <= 1;
	#100;
end
endtask


// Control signal sequence for the out instruction; Copies the value
// of the specified register and places it in the outport
task outportInstruction; begin
	// Load Register
	cycle <= -1; busDataIn <= 75; InPortOut <= 1; Gra <= 1; Rin <= 1;
	// T0 - T2
	instructionFetch;
	// T3
	cycle <= 3; setControlLow; Gra <= 1; Rout <= 1; outPortIn <= 1;
	#100;
end
endtask


// Control signal sequence for the mfhi instruction; Copies the value
// from the inport and stores it in the specified register
task inportInstruction; begin
	// T0 - T2
	instructionFetch;
	// T3
	cycle <= 3; setControlLow; busDataIn <= 450; InPortOut <= 1; Gra <= 1; Rin <= 1; // BusDataIn artifically adds a value into the inport
	#100;
end
endtask


endmodule
