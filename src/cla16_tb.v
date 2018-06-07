module cla16_tb;
	reg [31:0] test; //To number the tests
	
	//Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg Cin;
	
	//Outputs
	wire [15:0] S;
	wire Cout; //carry output
	wire PG; //group propagate
	wire GG; //group generate
	
	cla16 adder(S,Cout,PG,GG,A,B,Cin); //instantiate carry look-ahead adder algorithm module
	
	initial begin 
		//Initialize inputs
		A <= 0; 
		B <= 0; 
		Cin <= 0;
		#100
		
		//Add tests
		test <= 1; //both positive, no carry
		A <= 5;
		B <= 10;
		Cin <= 0; 
		#100
		test <= 2; //both positive, with carry
		A <= 50;
		B <= 25;
		Cin <= 1;
		#100
		test <= 3; //one negative, one positive, no carry
		A <= -5;
		B <= 10;
		Cin<= 0;
		#100;
	end
endmodule
