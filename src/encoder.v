// Simple encoder to generate bus select logic
module encoder (
	output reg 	[4:0] select,
	input wire	r0_en, r1_en, r2_en, r3_en, r4_en, r5_en, r6_en, r7_en, r8_en, r9_en, r10_en, r11_en, r12_en, r13_en, 
	r14_en, r15_en, HI_en, LO_en, PC_en, MDR_en, InPort_en, Zhigh_en, Zlow_en, C_en
);

initial begin
	select <= 5'bzzzzz;
end

always@(*) begin
	if(r0_en == 1) begin
		select = 5'b00000;
	end 
	if(r1_en == 1) begin
		select = 5'b00001;
	end 
	if(r2_en == 1) begin
		select = 5'b00010;
	end 
	if(r3_en == 1) begin
		select = 5'b00011;
	end 
	if(r4_en == 1) begin
		select = 5'b00100;
	end 
	if(r5_en == 1) begin
		select = 5'b00101;
	end 
	if(r6_en == 1) begin
		select = 5'b00110;
	end 
	if(r7_en == 1) begin
		select = 5'b00111;
	end 
	if(r8_en == 1) begin
		select = 5'b01000;
	end 
	if(r9_en == 1) begin
		select = 5'b01001;
	end 
	if(r10_en == 1) begin
		select = 5'b01010;
	end 
	if(r11_en == 1) begin
		select = 5'b01011;
	end 
	if(r12_en == 1) begin
		select = 5'b01100;
	end 
	if(r13_en == 1) begin
		select = 5'b01101;
	end 
	if(r14_en == 1) begin
		select = 5'b01110;
	end 
	if(r15_en == 1) begin
		select = 5'b01111;
	end
	if(HI_en == 1) begin
		select = 5'b10000;
	end
	if(LO_en == 1) begin
		select = 5'b10001;
	end
	if(PC_en == 1) begin
		select = 5'b10010;
	end
	if(MDR_en == 1) begin
		select = 5'b10011;
	end
	if(InPort_en == 1) begin
		select = 5'b10100;
	end
	if(Zhigh_en == 1) begin
		select = 5'b10101;
	end
	if(Zlow_en == 1) begin
		select = 5'b10110;
	end
	if(C_en == 1) begin
		select = 5'b10111;
	end
end
endmodule

		
		