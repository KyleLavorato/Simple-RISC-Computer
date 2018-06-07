module cla4 (
	output [3:0] S, //sum
	output Cout, PG, GG,
	input [3:0] X,Y,
	input Cin //input carry
	);
	
	wire[3:0] G,P,C; //generate, propagate, carry
			
		assign G = X & Y; //generate with bitwise AND
		assign P = X ^ Y; //propogate bitwise exclusive OR
		assign C[0] = Cin; //input carry
		assign C[1] = G[0] | (P[0] & C[0]);
		assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
		assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
		assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);
	 
		assign S = P ^ C; //sum is bitwise exclusive OR of propagate and carry bits 
		
		assign PG = P[3] & P[2] & P[1] & P[0]; //group propagate only if all propagates are 1
		assign GG = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]); //group generate if any of them are true
endmodule

module cla16 (
//combines four 4-bit CLAs
	output [15:0] S,
	output Cout,PG,GG,
	input [15:0] A,B,
	input Cin
	);
	
	wire [15:0] P,G;
	wire [3:0] C,Co,Po,Go;
	wire [3:0] S0,S1,S2,S3;
	
	assign G = A & B; //generate with bitwise AND
	assign P = A ^ B; //propogate bitwise exclusive OR
	
	assign C[0] = Cin;
	//C4
	assign C[1] = G[3] | 
					(P[3] & G[2]) | 
					(P[3] & P[2] & G[1]) | 
					(P[3] & P[2] & P[1] & G[0]) | 
					(P[3] & P[2] & P[1] & P[0] & C[0]);
	//C8
	assign C[2] = G[7] |
					(P[7] & G[6]) | 
					(P[7] & P[6] & G[5]) | 
					(P[7] & P[6] & P[5] & G[4]) | 
					(P[7] & P[6] & P[5] & P[4] & G[3]) | 
					(P[7] & P[6] & P[5] & P[4] & P[3] & G[2]) |
					(P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1]) |
					(P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0]) |
					(P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
	//C12
	assign C[3] = G[11] |
					(P[11] & G[10]) | 
					(P[11] & P[10] & G[9]) | 
					(P[11] & P[10] & P[9] & G[8]) | 
					(P[11] & P[10] & P[9] & P[8] & G[7]) | 
					(P[11] & P[10] & P[9] & P[8] & P[7] & G[6]) |
					(P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & G[5]) |
					(P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & G[4]) |
					(P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & G[3]) |
					(P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & G[2]) |
					(P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1]) |
					(P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0]) |
					(P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
	//C16
	assign Cout = G[15] |
					(P[15] & G[14]) | 
					(P[15] & P[14] & G[13]) | 
					(P[15] & P[14] & P[13] & G[12]) | 
					(P[15] & P[14] & P[13] & P[12] & G[11]) | 
					(P[15] & P[14] & P[13] & P[12] & P[11] & G[10]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & G[9]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & G[8]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & G[7]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & G[6]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & G[5]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & G[4]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & G[3]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & G[2]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0]) |
					(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
	
	//Pass to first level
	cla4 a(S0,Co[0],Po[0],Go[0],A[3:0],B[3:0],C[0]);
	cla4 b(S1,Co[1],Po[1],Go[1],A[7:4],B[7:4],C[1]);
	cla4 c(S2,Co[2],Po[2],Go[2],A[11:8],B[11:8],C[2]);
	cla4 d(S3,Co[3],Po[3],Go[3],A[15:12],B[15:12],C[3]);
	
	assign S = {S3,S2,S1,S0}; //vector
	
	//Accepted the group propagate and group generate from each of the four CLAs
	assign PG = Po[3] & Po[2] & Po[1] & Po[0];
	assign GG = Go[3] | (Po[3] & Go[2]) | (Po[3] & Po[2] & Go[1]) | (Po[3] & Po[2] & Po[1] & Go[0]);
endmodule
