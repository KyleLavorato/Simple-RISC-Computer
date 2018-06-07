// Simple 64 bit register, high or low 32bits are selected via enable
module reg64 (
	output reg [31:0] HI, LO,
	input wire [63:0] data_in,
	input wire en, clk, clr, LO_en, HI_en
);

reg [63:0] data;
wire [63:0] data_wire;
assign data_wire = data;

// Set initial value
initial begin
	data <= 0;
	HI <= 0;
	LO <= 0;
end

always@(*) begin
	if (LO_en == 1)
		LO = data_wire[31:0];
	if (HI_en == 1)
		HI = data_wire[63:32];
end
		
always@(posedge clk, posedge clr) begin
	if(clr == 1)
		data <= 0;
	else if (en == 1)
		data <= data_in;
end

endmodule
