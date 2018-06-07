// Simple 100ps clock
module Clock(
	output reg clk
);

always begin
	clk = 1;
	#50;
	clk = 0;
	#50;
end

endmodule
