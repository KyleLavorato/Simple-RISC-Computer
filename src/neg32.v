// Simple NEG circuit for ALU output
module neg32(
	output wire [31:0] out,
	input wire [31:0] in_a
);
	// Take inversion of input
	wire[31:0] not_a;
	assign not_a = ~in_a;
	
	// Add one to complete two's complement
	addOne twosCompAdd(not_a, out);
	
endmodule
