// Module to generate the control signals for register input and output selection
// Also populates the c_sign_extended value
module selectAndEncode(
	output reg [31:0] c_sign_extended,
	output wire r0In, r1In, r2In, r3In, r4In, r5In, r6In, r7In, r8In, r9In, r10In, r11In,
	r12In, r13In, r14In, r15In,
	output wire r0Out, r1Out, r2Out, r3Out, r4Out, r5Out, r6Out, r7Out, r8Out, r9Out, r10Out, r11Out,
	r12Out, r13Out, r14Out, r15Out,
	input wire [31:0] IR_data,
	input wire Gra, Grb, Grc, Rin, Rout, BAout
);

wire RBAout;
assign RBAout = Rout | BAout;

wire [3:0] RaOut, RbOut, RcOut;

assign RaOut[0] = IR_data[23] & Gra;
assign RaOut[1] = IR_data[24] & Gra;
assign RaOut[2] = IR_data[25] & Gra;
assign RaOut[3] = IR_data[26] & Gra;

assign RbOut[0] = IR_data[19] & Grb;
assign RbOut[1] = IR_data[20] & Grb;
assign RbOut[2] = IR_data[21] & Grb;
assign RbOut[3] = IR_data[22] & Grb;

assign RcOut[0] = IR_data[15] & Grc;
assign RcOut[1] = IR_data[16] & Grc;
assign RcOut[2] = IR_data[17] & Grc;
assign RcOut[3] = IR_data[18] & Grc;

wire [3:0] decoderIn;
wire r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;

assign decoderIn = RaOut | RbOut | RcOut;

Decode4to16 decoder(decoderIn, r0, r1, r10, r11, r12, r13, r14, r15, r2, r3, r4, r5, r6, r7, r8, r9);

assign r0In = r0 & Rin;
assign r1In = r1 & Rin;
assign r2In = r2 & Rin;
assign r3In = r3 & Rin;
assign r4In = r4 & Rin;
assign r5In = r5 & Rin;
assign r6In = r6 & Rin;
assign r7In = r7 & Rin;
assign r8In = r8 & Rin;
assign r9In = r9 & Rin;
assign r10In = r10 & Rin;
assign r11In = r11 & Rin;
assign r12In = r12 & Rin;
assign r13In = r13 & Rin;
assign r14In = r14 & Rin;
assign r15In = r15 & Rin;

assign r0Out = r0 & RBAout;
assign r1Out = r1 & RBAout;
assign r2Out = r2 & RBAout;
assign r3Out = r3 & RBAout;
assign r4Out = r4 & RBAout;
assign r5Out = r5 & RBAout;
assign r6Out = r6 & RBAout;
assign r7Out = r7 & RBAout;
assign r8Out = r8 & RBAout;
assign r9Out = r9 & RBAout;
assign r10Out = r10 & RBAout;
assign r11Out = r11 & RBAout;
assign r12Out = r12 & RBAout;
assign r13Out = r13 & RBAout;
assign r14Out = r14 & RBAout;
assign r15Out = r15 & RBAout;

initial begin
	c_sign_extended = 0;
end

always @(*) begin
	c_sign_extended[18:0] <= IR_data[18:0];
	c_sign_extended[19] <= IR_data[18];
	c_sign_extended[20] <= IR_data[18];
	c_sign_extended[21] <= IR_data[18];
	c_sign_extended[22] <= IR_data[18];
	c_sign_extended[23] <= IR_data[18];
	c_sign_extended[24] <= IR_data[18];
	c_sign_extended[25] <= IR_data[18];
	c_sign_extended[26] <= IR_data[18];
	c_sign_extended[27] <= IR_data[18];
	c_sign_extended[28] <= IR_data[18];
	c_sign_extended[29] <= IR_data[18];
	c_sign_extended[30] <= IR_data[18];
	c_sign_extended[31] <= IR_data[18];
end	

endmodule
