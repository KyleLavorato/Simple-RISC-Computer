module booth32(
	output wire [64:1] data_out,
	input wire [31:0] a, b
	);
	
	reg [64:0] product; //64 bit product 
	initial product <= 0; //only once
	assign data_out[64:1] = product[64:1];
	
	integer i; //variable for for-loop

	always @(*) begin //complete each time input changes
		product[0] = 0; //first bit is zero
		product[64:33] = 4'b0; //last 32 bits equal 0
		product[32:1] = a; //next 32 bits equal the input

		for(i = 0; i < 32; i = i + 1) begin //executes 32 times (for all bits)
			if (product[1] == 0 && product[0] == 1) begin //if a 0 and 1
			product[64:33] = product[64:33] + b; //add input
			end
			else if (product[1] == 1 && product[0] == 0) begin
					product[64:33] = product[64:33] - b; //if a 1 and 0
			end
			product = product >> 1; //right shift adds zeros
			product[64] = product[63]; //move to next bit in product
		end
	end
endmodule

