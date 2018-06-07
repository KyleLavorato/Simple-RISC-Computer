// Module to define the conFF logic for branch instructions
module conFF(
	output reg conOut,
	input wire[31:0] bus_data,
	input wire[1:0] IR_data,
	input wire clk, conIn
);

reg compare;

// conFFCompare is a MegaFunction implimentation of the comparator circuit
wire eq, ge, lt, ne;
conFFCompare comparator(bus_data, eq, ge, lt, ne);

initial begin
	conOut <= 0;
	compare <= 0;
end

// Encoder selects the output based off of the IR select signal
always @(*) begin
	if(IR_data == 'b00)
		compare <= eq;
	else if(IR_data == 'b01)
		compare <= ne;
	else if(IR_data == 'b10)
		compare <= ge;
	else
		compare <= lt;
end

always @(posedge clk) begin
	if(conIn == 1)
		conOut <= compare;
end
endmodule
