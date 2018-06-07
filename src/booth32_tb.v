module booth32_tb;
	
	reg [31:0] test; //To number the tests
	
	reg [31:0] a;
	reg [31:0] b;
	wire [63:0] data_out;
	
	booth32 multiplier(data_out, a, b); //Instantiate booth algorithm module
	
	initial begin //executed once when the simulation starts
		//Initialize inputs
		a <= 0;
		b <= 0;
		#100
		
		//Add tests
		test <= 1; //both positive
		a <= 65;
		b <= 200;
		#100
		test <= 2;
		a <= 1;
		b <= 1;
		#100
		test <= 3; //one positive, one negative
		a <= -5;
		b <= 8;
		#100
		test <= 4; //both negative
		a <= -10;
		b <= -6;
		#100;
	end
endmodule
