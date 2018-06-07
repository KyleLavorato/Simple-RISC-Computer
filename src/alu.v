// Opcode Table
// add 5'b00101
// sub 5'b00110
// mul 5'b10001
// div 5'b10010
// and 5'b00111
// or  5'b01000
// shr 5'b01001
// shl 5'b01011
// ror 5'b01100
// rol 5'b01101
// neg 5'b10011
// not 5'b10100
// inc 5'b11101

// Standard ALU with support to increment PC
module alu (
	output reg [63:0] z,
	input wire [31:0] a_in, b_in,
	input wire [4:0] opcode,
	input wire incPC
);

wire [31:0] add_out;
wire [31:0] sub_out;
wire [63:0] mul_out;
wire [31:0] div_out, remainder;
wire [31:0] and_out;
wire [31:0] or_out;
wire [31:0] shr_out;
wire [31:0] shl_out;
wire [31:0] ror_out;
wire [31:0] rol_out;
wire [31:0] neg_out;
wire [31:0] not_out;
wire [31:0] PC_out;
wire [31:0] inc_out;
add32 add1(a_in, b_in, add_out);
sub32 sub1(a_in, b_in, sub_out);
mul32 mul1(b_in, a_in, mul_out);
div32 div1(b_in, a_in, div_out, remainder);
and32 and1(and_out, a_in, b_in);
or32 or1(or_out, a_in, b_in);
shr32 shr1(a_in, b_in[4:0], shr_out);
shl32 shl1(a_in, b_in[4:0], shl_out);
ror32 ror1(a_in, b_in[4:0], ror_out);
rol32 rol1(a_in, b_in[4:0], rol_out);
neg32 neg1(neg_out, b_in);
not32 not1(not_out, b_in);
addOne add2(b_in, PC_out);
addOne add3(b_in, inc_out);


// Set initial value
initial begin
	z <= 0;
end

always@(*) begin
		if (incPC == 1) begin
			z[31:0] <= PC_out;
			z[63:32] <= 0;
		end
		// ADD || ADDI
		else if (opcode == 5'b00101 || opcode == 5'b01101) begin
			z[31:0] <= add_out;
			z[63:32] <= 0;
		end
		
		// SUB
		else if (opcode == 5'b00110) begin
			z[31:0] <= sub_out;
			z[63:32] <= 0;
		end
		
		// MUL
		else if (opcode == 5'b10000) begin
			z <= mul_out;
		end
		
		// DIV
		else if (opcode == 5'b10001) begin
			z[31:0] <= div_out;
			z[63:32] <= remainder;
		end
		
		// AND || ANDI
		else if (opcode == 5'b00111 || opcode == 5'b01110) begin
			z[31:0] <= and_out;
			z[63:32] <= 0;
		end
		
		// OR || ORI
		else if (opcode == 5'b01000 || opcode == 5'b01111) begin
			z[31:0] <= or_out;
			z[63:32] <= 0;
		end
		
		// SHR
		else if (opcode == 5'b01001) begin
			z[31:0] <= shr_out;
			z[63:32] <= 0;
		end
		
		// SHL
		else if (opcode == 5'b01010) begin
			z[31:0] <= shl_out;
			z[63:32] <= 0;
		end
		
		// ROR
		else if (opcode == 5'b01011) begin
			z[31:0] <= ror_out;
			z[63:32] <= 0;
		end
		
		// ROL
		else if (opcode == 5'b01100) begin
			z[31:0] <= rol_out;
			z[63:32] <= 0;
		end
		
		// NEG
		else if (opcode == 5'b10010) begin
			z[31:0] <= neg_out;
			z[63:32] <= 0;
		end
		
		// NOT
		else if (opcode == 5'b10011) begin
			z[31:0] <= not_out;
			z[63:32] <= 0;
		end
		
		// INC
		else if(opcode == 5'b11101) begin
			z[31:0] <= inc_out;
			z[63:32] <= 0;
		end
		
		else
			z[63:0] <= 0;
end
endmodule
