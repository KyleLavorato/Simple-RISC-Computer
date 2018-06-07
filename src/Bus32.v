// Simple 32 bit bus that uses an encoder select approach
module Bus32 (
	output reg [31:0] busDataOut,
	input wire [31:0] BusMux_r0, BusMux_r1, BusMux_r2, BusMux_r3, 
	BusMux_r4, BusMux_r5, BusMux_r6, BusMux_r7, BusMux_r8, 
	BusMux_r9, BusMux_r10, BusMux_r11, BusMux_r12, BusMux_r13, 
	BusMux_r14, BusMux_r15, BusMux_HI, BusMux_LO, BusMux_PC, BusMux_MDR, 
	BusMux_InPort, BusMux_Zhigh, BusMux_Zlow, c_sign_extended,
	input	[4:0] select
);

always@(*) begin
	case(select)
		5'b00000 : busDataOut <= BusMux_r0;
		5'b00001 : busDataOut <= BusMux_r1;
		5'b00010 : busDataOut <= BusMux_r2;
		5'b00011 : busDataOut <= BusMux_r3;
		5'b00100 : busDataOut <= BusMux_r4;
		5'b00101 : busDataOut <= BusMux_r5;
		5'b00110 : busDataOut <= BusMux_r6;
		5'b00111 : busDataOut <= BusMux_r7;
		5'b01000 : busDataOut <= BusMux_r8;
		5'b01001 : busDataOut <= BusMux_r9;
		5'b01010 : busDataOut <= BusMux_r10;
		5'b01011 : busDataOut <= BusMux_r11;
		5'b01100 : busDataOut <= BusMux_r12;
		5'b01101 : busDataOut <= BusMux_r13;
		5'b01110 : busDataOut <= BusMux_r14;
		5'b01111 : busDataOut <= BusMux_r15;
		5'b10000 : busDataOut <= BusMux_HI;
		5'b10001 : busDataOut <= BusMux_LO;
		5'b10010 : busDataOut <= BusMux_PC;
		5'b10011 : busDataOut <= BusMux_MDR;
		5'b10100 : busDataOut <= BusMux_InPort;
		5'b10101 : busDataOut <= BusMux_Zhigh;
		5'b10110 : busDataOut <= BusMux_Zlow;
		5'b10111 : busDataOut <= c_sign_extended;
	endcase
end
endmodule

		
		