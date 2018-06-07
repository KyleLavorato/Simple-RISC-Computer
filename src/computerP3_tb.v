// Testbench for the main datapath
module computerP3_tb;

// Output signals
reg [31:0] busDataIn;
reg reset;
computer cp(
	reset,
	busDataIn
);

initial begin
	reset <= 1;
	#101
	reset <= 0;
end
	
endmodule
