// An inferred memory stack module of size 32x32
module stack32(
	output reg [31:0] data_out,
	input wire [31:0] data_in, 
	input wire read, write
	
);

reg [31:0] i;

reg[31:0] sp;

reg [31:0] stk [31:0];

initial begin
	data_out <= 32'b00000000000000000000000000000000;
	sp <= 1;
	
	// ORG $0
	for (i = 0; i < 31; i = i + 1) begin
		stk[i] <= 0;
	end
end
	
always@(read, write) begin
	if(read == 1) begin
		sp = sp - 1;
		data_out = stk[sp];
	end
	else if(write == 1) begin
		stk[sp] = data_in;
		sp = sp + 1;
		data_out = 32'b00000000000000000000000000000000;
	end
	else
		data_out = 32'b00000000000000000000000000000000;
end

endmodule
