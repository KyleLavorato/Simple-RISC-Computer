// Simple OR circuit for ALU output
module or32(
	output wire [31:0] out,
	input wire [31:0] in_a, in_b
);
	// Output is or of inputs
	assign out = in_a | in_b;
	
endmodule
