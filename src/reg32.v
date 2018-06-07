// Simple 32 bit register with enable and clear
module reg32 (
	output reg [31:0] q,
	input wire [31:0] d,
	input wire en, clk, clr
);

// Set initial value
initial begin
	q <= 0;
end

always@(posedge clk, posedge clr) begin
		if(clr == 1) begin
			q <= 0;
		end
		else if (en == 1) begin
			q <= d;
		end
end
endmodule
