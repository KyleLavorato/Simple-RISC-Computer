// Memory Data Register with encoder logic for outout
module mdr (
	output reg [31:0] data_out,
	input wire [31:0] mem_data_in, bus_data_in,
	input wire en, clk, clr, read
);

// Set initial value
initial begin
	data_out <= 0;
end

always@(posedge clk, posedge clr) begin
		if(clr == 1) begin
			data_out <= 0;
		end
		
		else if (en == 1) begin
			if(read == 1)
				data_out <= mem_data_in;
			else
				data_out <= bus_data_in;
		end
end
endmodule
