// Simple 32 bit register with enable, clear and zero enable
module regR0 (
	output reg [31:0] q,
	input wire [31:0] d,
	input wire en, clk, clr, BAout
);

reg[31:0] data;

// Set initial value
initial begin
	q <= 0;
	data <= 0;
end

always@(posedge clk, posedge clr, posedge BAout) begin
		if(clr == 1 || BAout == 1) begin
			q <= 0;
		end
		else if (en == 1) begin
			data <= d;
			q <= data;
		end
		else
			q <= data;
end
endmodule
