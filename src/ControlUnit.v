module ControlUnit(
	output reg Rin, Rout, Gra, Grb, Grc,
	output reg HIin, LOin, CONin, PCin, IRin, Yin, Zin, MARin, MDRin, OutPortin, Cout, InPortout, BAout,
	output reg PCout, MDRout, Zhighout, Zlowout, HIout, LOout,
	output reg incPC,
	output reg[4:0] opcode_data,
	output reg read, write, sread, swrite, run, clr,
	output wire[5:0] stateOut,
	input wire clk, reset, stop, conFF,
	input wire[31:0] IR
);

reg[6:0] present_state;
wire[4:0] opcode;
assign opcode = IR[31:27];
assign stateOut = present_state;

parameter	fetch0 = 0,
				fetch1 = 1,
				fetch2 = 2,
				add3 = 3,
				add4 = 4,
				add5 = 5,
				addi4 = 6,
				mul3 = 7,
				mul4 = 8,
				mul5 = 9,
				mul6 = 10,
				neg3 = 11,
				neg4 = 12,
				neg5 = 13,
				ld3 = 14,
				ld4 = 15,
				ld5 = 16,
				ld6 = 17,
				ld7 = 18,
				ldi5 = 19,
				ldr3 = 20,
				ldr4 = 21,
				ldr5 = 22,
				ldr6 = 23,
				ldr7 = 24,
				st6 = 25,
				st7 = 26,
				br3 = 27,
				br4 = 28,
				jp3 = 29,
				jal3 = 30,
				jal4 = 31,
				jal5 = 32,
				mfhi3 = 33,
				mflo3 = 34,
				out3 = 35,
				in3 = 36,
				halt3 = 38,
				inc3 = 39,
				inc4 = 40,
				ldstk3 = 41,
				ldstk4 = 42,
				ststk3 = 43,
				ststk4 = 44,
				end_state = 7'b0111110,
				reset_state = 7'b0111111;

always @(posedge clk) begin
	#1;
	if(reset == 1)
		present_state <= reset_state;
	else
		case(present_state)
			reset_state: present_state <= fetch0;
			fetch0: present_state <= fetch1;
			fetch1: present_state <= fetch2;
			
			fetch2:
			begin
				case(opcode)
					5'b00000: present_state <= ld3;
					5'b00001: present_state <= ld3; //ldi
					5'b00010: present_state <= ld3; //st
					5'b00011: present_state <= ldr3;
					5'b00100: present_state <= ldr3; //str
					5'b00101: present_state <= add3;
					5'b00110: present_state <= add3; //sub
					5'b00111: present_state <= add3; //and
					5'b01000: present_state <= add3; //or
					5'b01001: present_state <= add3; //shr
					5'b01010: present_state <= add3; //shl
					5'b01011: present_state <= add3; //ror
					5'b01100: present_state <= add3; //rol
					5'b01101: present_state <= add3; //addi
					5'b01110: present_state <= add3; //andi
					5'b01111: present_state <= add3; //ori
					5'b10000: present_state <= mul3; //mul
					5'b10001: present_state <= mul3; //div
					5'b10010: present_state <= neg3;
					5'b10011: present_state <= neg3; //not
					5'b10100: present_state <= br3;
					5'b10101: present_state <= jp3;
					5'b10110: present_state <= jal3;
					5'b10111: present_state <= in3;
					5'b11000: present_state <= out3;
					5'b11001: present_state <= mfhi3;
					5'b11010: present_state <= mflo3;
					5'b11011: present_state <= reset_state; //nop
					5'b11100: present_state <= halt3;
					5'b11101: present_state <= inc3;
					5'b11110: present_state <= ldstk3;
					5'b11111: present_state <= ststk3;
				endcase
			end
			
			add3:
			begin
				case(opcode)
					5'b01101: present_state <= addi4; //addi
					5'b01110: present_state <= addi4; //andi
					5'b01111: present_state <= addi4; //ori
					5'b10000: present_state <= mul4; //mul
					5'b10001: present_state <= mul4; //div
					default: present_state <= add4;
				endcase
			end
			add4: present_state <= add5;
			add5: present_state <= reset_state;
			
			//addi/andi/ori uses add3 and add5
			addi4: present_state <= add5;
			
			//sub uses add3 and add5
			
			mul3: present_state <= mul4;
			mul4: present_state <= mul5;
			mul5: present_state <= mul6;
			mul6: present_state <= reset_state;
			
			//not uses neg3-5
			neg3: present_state <= neg4;
			neg4: present_state <= neg5;
			neg5: present_state <= reset_state;
			
			//div uses add3 and mul5-6
			
			//and uses add3 and add5
			
			//or uses add3 and add5
			
			//shr uses add3 and add5
			
			//shl uses add3 and add5
			
			//ror uses add3 and add5
			
			//rol uses add3 and add5
			
			ld3: present_state <= ld4;
			ld4: 
			begin
				// if ld or st
				if(opcode == 5'b00000 || opcode == 5'b00010)
					present_state <= ld5;
				else
					present_state <= ldi5;
			end
			ld5: 
			begin
				if(opcode == 5'b00000)
					present_state <= ld6;
				else
					present_state <= st6;
			end
			ld6: present_state <= ld7;
			ld7: present_state <= reset_state;
			
			//ldi uses ld3-4
			ldi5: present_state <= reset_state;
			
			ldr3: present_state <= ldr4;
			ldr4: present_state <= ldr5;
			ldr5: 
			begin
				if(opcode == 5'b00011)
					present_state <= ldr6;
				else
					present_state <= st6; //str
			end
			ldr6: present_state <= ldr7;
			ldr7: present_state <= reset_state;
			
			//st uses ld3-5
			st6: present_state <= st7;
			st7: present_state <= reset_state;
			
			//str uses ldr3-4 and st6-7 (as str5-6)
			
			//brzr/brnz/brmi/brpl all use same seq
			br3: present_state <= br4;
			br4: present_state <= reset_state;
			
			jp3: present_state <= reset_state;
			
			//jal uses jp3 as jal6
			jal3: present_state <= jal4;
			jal4: present_state <= jal5;
			jal5: present_state <= jp3;
			
			mfhi3: present_state <= reset_state;
			
			mflo3: present_state <= reset_state;
			
			out3: present_state <= reset_state;
			
			in3: present_state <= reset_state;
			
			inc3: present_state <= inc4;
			inc4: present_state <= reset_state;
			
			ldstk3: present_state <= ldstk4;
			ldstk4: present_state <= reset_state;
			ststk3: present_state <= ststk4;
			ststk4: present_state <= reset_state;
			
			halt3: present_state <= end_state;
			end_state: present_state <= end_state;
		endcase
end

always @(present_state) begin
	Rin <= 0; Rout <= 0; Gra <= 0; Grb <= 0; Grc <= 0; HIin <= 0; LOin <= 0; 
	CONin <= 0; PCin <= 0; IRin <= 0; Yin <= 0; Zin <= 0; MARin <= 0; MDRin <=0;
	OutPortin <= 0; Cout <= 0; InPortout <= 0; BAout <= 0; incPC <= 0; read <= 0;
	write <= 0; run <= 0; clr <= 0; PCout <= 0; MDRout <= 0; Zhighout <= 0;
	Zlowout <= 0; HIout <= 0; LOout <= 0; sread <= 0; swrite <= 0; opcode_data <= 5'b00000;
	
	case(present_state)
		fetch0: begin PCout <= 1; MARin <= 1; incPC <= 1; Zin <= 1; end
		fetch1: begin Zlowout <= 1; PCin <= 1; read <= 1; MDRin <= 1; end
		fetch2: begin MDRout <= 1; IRin <= 1; end
		add3: begin Grb <= 1; Rout <= 1; Yin <= 1; end
		add4: begin Grc <= 1; Rout <= 1; opcode_data <= opcode; Zin <= 1; end
		add5: begin Zlowout <= 1; Gra <= 1; Rin <= 1; end
		addi4: begin Cout <= 1; opcode_data <= opcode; Zin <= 1; end
		mul3: begin Gra <= 1; Rout <= 1; Yin <= 1; end
		mul4: begin Grb <= 1; Rout <= 1; opcode_data <= opcode; Zin <= 1; end
		mul5: begin Zlowout <= 1; LOin <= 1; end
		mul6: begin Zhighout <= 1; HIin <= 1; end
		neg3: begin Grb <= 1; Rout <= 1; opcode_data <= opcode; Zin <= 1; end
		neg4: begin end
		neg5: begin Zlowout <= 1; Gra <= 1; Rin <= 1; end
		ld3: begin BAout <= 1; Grb <= 1; Yin <= 1; end
		ld4: begin Cout <= 1; opcode_data <= 5'b00101; Zin <= 1; end
		ld5: begin Zlowout <= 1; MARin <= 1; end
		ld6: begin read <= 1; MDRin <= 1; end
		ld7: begin MDRout <= 1; Gra <= 1; Rin <= 1; end
		ldi5: begin Zlowout <= 1; Gra <= 1; Rin <= 1; end
		ldr3: begin PCout <= 1; Yin <= 1; end
		ldr4: begin Cout <= 1; opcode_data <= 5'b00101; Zin <= 1; end
		ldr5: begin Zlowout <= 1; MARin <= 1; end
		ldr6: begin read <= 1; MDRin <= 1; end
		ldr7: begin MDRout <= 1; Gra <= 1; Rin <= 1; end
		st6: begin Gra <= 1; Rout <= 1; MDRin <= 1; end
		st7: begin write <= 1; end
		br3: begin Gra <= 1; Rout <= 1; CONin <= 1; end
		br4: 
		begin
			Grb <= 1; Rout <= 1;
			if(conFF)
				PCin <= 1;
		end
		jp3: begin Gra <= 1; Rout <= 1; PCin <= 1; end
		jal3: begin PCout <= 1; Yin <= 1; end
		jal4: begin Cout <= 1; opcode_data <= 5'b00101; Zin <= 1; end
		jal5: begin Zlowout <= 1; Grb <= 1; Rin <= 1; end
		mfhi3: begin HIout <= 1; Gra <= 1; Rin <= 1; end
		mflo3: begin LOout <= 1; Gra <= 1; Rin <= 1; end
		out3: begin Gra <= 1; Rout <= 1; OutPortin <= 1; end
		in3: begin InPortout <= 1; Gra <= 1; Rin <= 1; end
		inc3: begin Gra <= 1; Rout <= 1; opcode_data <= opcode; Zin <= 1; end
		inc4: begin Zlowout <= 1; Gra <= 1; Rin <= 1; end
		ldstk3: begin sread <= 1; MDRin <= 1; end
		ldstk4: begin MDRout <= 1; Gra <= 1; Rin <= 1; end
		ststk3: begin Gra <= 1; Rout <= 1; MDRin <= 1; end
		ststk4: begin swrite <= 1; end
	endcase
end

endmodule
