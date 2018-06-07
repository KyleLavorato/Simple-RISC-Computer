// Simple NOT circuit for ALU output
module not32(
	output wire [31:0] out,
	input wire [31:0] in_a
);
	// Output is inversion of input
	assign out = ~in_a;
	
endmodule
