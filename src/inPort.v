// A simple inport with no strobe that recieves data to be used by the machine
module inPort(
	output reg[31:0] dataOut,
	input wire[31:0] dataIn,
	input wire clr, clk
);


initial begin
	dataOut <= 0;
end

always @(*) begin
	if(clr == 1)
		dataOut <= 0;
	else
		dataOut <= dataIn;
end

endmodule
