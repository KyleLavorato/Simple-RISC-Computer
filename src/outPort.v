// A simple outport that recieves data as input to be used externally
module outPort(
	output reg [31:0] dataOut,
	input wire[31:0] dataIn,
	input wire clr, clk, en
);

initial begin
	dataOut <= 0;
end

always @(posedge clk, posedge clr) begin
	if(clr == 1)
		dataOut <= 0;
	else if(en == 1)
		dataOut <= dataIn;
end

endmodule
