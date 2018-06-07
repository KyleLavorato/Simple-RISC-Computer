// Simple AND circuit for ALU output
module and32(
	output wire [31:0] out,
	input wire [31:0] in_a, in_b
);
	// Output is and of inputs
	assign out = in_a & in_b;
	
endmodule
