// input:reset,start,mode(3)
// mq47,r31,msb,ms0_23,mp47,ms0_24,ms0_31
// comp1_g, comp2_g
// stxor
// st, sumor

// output:mux1(2), mux2(3), m3(3), m4(2), m5(1), m6(2), m7(1), m8(3), m9(3), m10(1)
//	m11(1), m12(2), m13(3), m14(2), m15(1), m16(1), m17(3), m18(1), m19(1), m20(2)
//	m21(2), m22(1), m23(1)
// rf_wa,rf_we, rf_raa, rf_rea, rf_rab, rf_reb
// reg_sum, reg_i,reg_currterm,reg_index,reg_reg,reg_r,reg_numbit,reg_e,reg_acc,
// reg_sc,reg_ec,reg_mc,reg_sb,reg_eb,reg_mb,reg_sa,reg_ea,reg_ma
// reg_sq,reg_eq,reg_ss,reg_es,reg_ms,reg_st,reg_et,reg_sp,reg_ep
// reg_es0, reg_ss0
// sr_res, sr_mq, sr_mt, sr_mp
// ssr_ms0(3)
// alu1(3=opcode,M=1), alu2(3)
// counterii(3, load,e,d)


module FSM( clk, reset, start,
mq47, mp47, r31, msb, ms0_24,ms0_23, ms0_63,
comp1_g, comp2_g, stxor, st, sumor, mode,
mux5, mux7, mux10, mux11, mux15, mux16, mux18, mux19, mux22, mux23,
mux1, mux4, mux6, mux12, mux14, mux20, mux21,
mux2, mux3, mux8, mux9, mux13, mux17,
rf_we, rf_rea, rf_reb, rf_wa, rf_raa, rf_rab,
reg_sum, reg_i, reg_currterm, reg_index, reg_reg, reg_r, reg_numbit, reg_e, reg_acc,
reg_sc, reg_ec, reg_mc, reg_sb, reg_eb, reg_mb, reg_sa, reg_ea, reg_ma,
reg_sq, reg_eq, reg_ss, reg_es, reg_ms, reg_st, reg_et, reg_sp, reg_ep,
reg_es0, reg_ss0,
sr_res, sr_mq, sr_mt, sr_mp, ssr_ms0,
alu1, alu2, counterii, state);

input reset, start, clk;
input mq47, mp47, r31, msb,ms0_23, ms0_24, ms0_63;
input comp1_g, comp2_g, stxor, st, sumor;
input[2:0] mode;

output mux5, mux7, mux10, mux11, mux15, mux16, mux18, mux19, mux22, mux23;
output[1:0] mux1, mux4, mux6, mux12, mux14, mux20, mux21;
output[2:0] mux2, mux3, mux8, mux9, mux13, mux17;
output rf_we, rf_rea, rf_reb;
output[5:0] rf_wa, rf_raa, rf_rab;
output reg_sum, reg_i, reg_currterm, reg_index, reg_reg, reg_r, reg_numbit, reg_e, reg_acc;
output reg_sc, reg_ec, reg_mc, reg_sb, reg_eb, reg_mb, reg_sa, reg_ea, reg_ma;
output reg_sq, reg_eq, reg_ss, reg_es, reg_ms, reg_st, reg_et, reg_sp, reg_ep;
output reg_es0, reg_ss0;
output[1:0] sr_res, sr_mq, sr_mt, sr_mp;
output[2:0] ssr_ms0;
output[2:0] alu1, alu2;
output[2:0] counterii;
output [8:0] state;

reg mux5, mux7, mux10, mux11, mux15, mux16, mux18, mux19, mux22, mux23;
reg[1:0] mux1, mux4, mux6, mux12, mux14, mux20, mux21;
reg[2:0] mux2, mux3, mux8, mux9, mux13, mux17;
reg rf_we, rf_rea, rf_reb;
reg[5:0] rf_wa, rf_raa, rf_rab;
reg reg_sum, reg_i, reg_currterm, reg_index, reg_reg, reg_r, reg_numbit, reg_e, reg_acc;
reg reg_sc, reg_ec, reg_mc, reg_sb, reg_eb, reg_mb, reg_sa, reg_ea, reg_ma;
reg reg_sq, reg_eq, reg_ss, reg_es, reg_ms, reg_st, reg_et, reg_sp, reg_ep;
reg reg_es0, reg_ss0;
reg[1:0] sr_res, sr_mq, sr_mt, sr_mp;
reg[2:0] ssr_ms0;
reg[2:0] alu1, alu2;
reg[2:0] counterii;



parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, S9=9,
	S10=10, S11=11, S12=12, S13=13, S14=14, S15=15, S16=16, S17=17, S18=18, S19=19,
	S20=20, S21=21, S22=22, S23=23, S24=24, S25=25, S26=26, S27=27, S28=28, S29=29,
	S30=30, S31=31, S32=32, S33=33, S34=34, S35=35, S36=36, S37=37, S38=38, S39=39,
	S40=40, S41=41, S42=42, S43=43, S44=44, S45=45, S46=46, S47=47, S48=48, S49=49,
	S50=50, S51=51, S52=52, S53=53, S54=54, S55=55, S56=56, S57=57, S58=58, S59=59,
	S60=60, S61=61, S62=62, S63=63, S64=64, S65=65, S66=66, S67=67, S68=68, S69=69,
	S70=70, S71=71, S72=72, S73=73, S74=74, S75=75, S76=76, S77=77, S78=78, S79=79,
	S80=80, S81=81, S82=82, S83=83, S84=84, S85=85, S86=86, S87=87, S88=88, S89=89,
	S90=90, S91=91, S92=92, S93=93, 
	
	S52a=152, S53a=153, S54a=154, S55a=155, S56a=156, S57a=157, S58a=158, S59a=159,
	S60a=160, S61a=161, S62a=162, S63a=163, S64a=164, S65a=165, S66a=166, S67a=167, S68a=168, S69a=169,
	S70a=170, S71a=171, S72a=172, S73a=173, S74a=174, S75a=175, S76a=176, S77a=177, S78a=178, S79a=179,
	S80a=180, S81a=181, S82a=182, S83a=183, S84a=184, S85a=185, S86a=186, S87a=187, S88a=188, S89a=189,
	S90a=190, S91a=191, S92a=192, S93a=193,
	
	S52b=252, S53b=253, S54b=254, S55b=255, S56b=256, S57b=257, S58b=258, S59b=259,
	S60b=260, S61b=261, S62b=262, S63b=263, S64b=264, S65b=265, S66b=266, S67b=267, S68b=268, S69b=269,
	S70b=270, S71b=271, S72b=272, S73b=273, S74b=274, S75b=275, S76b=276, S77b=277, S78b=278, S79b=279,
	S80b=280, S81b=281, S82b=282, S83b=283, S84b=284, S85b=285, S86b=286, S87b=287, S88b=288, S89b=289,
	S90b=290, S91b=291, S92b=292, S93b=293, 

	S52c=352, S53c=353, S54c=354, S55c=355, S56c=356, S57c=357, S58c=358, S59c=359,
	S60c=360, S61c=361, S62c=362, S63c=363, S64c=364, S65c=365, S66c=366, S67c=367, S68c=368, S69c=369,
	S70c=370, S71c=371, S72c=372, S73c=373, S74c=374, S75c=375, S76c=376, S77c=377, S78c=378, S79c=379,
	S80c=380, S81c=381, S82c=382, S83c=383, S84c=384, S85c=385, S86c=386, S87c=387, S88c=388, S89c=389,
	S90c=390, S91c=391, S92c=392, S93c=393;

reg [8:0] state;
reg [8:0] nextstate;

always
   begin
      @(posedge clk);
	if (reset) state <= S0;
	state <= nextstate;
   end

always @ (state or reset or start or mq47 or mp47 or r31 or msb or ms0_23 or ms0_24 or ms0_63 
		or comp1_g or comp2_g or stxor or st or sumor or mode)
begin

//all outputs =0
mux5 <= 1'b0;
mux7 <= 1'b0;
mux10 <= 1'b0; 
mux11 <= 1'b0;
mux15 <= 1'b0;
mux16 <= 1'b0;
mux18 <= 1'b0;
mux19 <= 1'b0;
mux22 <= 1'b0;
mux23 <= 1'b0;
mux1 <= 2'b00;
mux4 <= 2'b00;
mux6 <= 2'b00;
mux12 <= 2'b00;
mux14 <= 2'b00;
mux20 <= 2'b00;
mux21 <= 2'b00;
mux2 <= 3'b000;
mux3 <= 3'b000;
mux8 <= 3'b000;
mux9 <= 3'b000;
mux13 <= 3'b000;
mux17 <= 3'b000;

rf_we <= 1'b0; 
rf_rea <= 1'b0;
rf_reb <= 1'b0;
rf_wa <= 6'b000000;
rf_raa <= 6'b000000;
rf_rab <= 6'b000000;

reg_sum <= 1'b0; 
reg_i <= 1'b0; 
reg_currterm <= 1'b0; 
reg_index <= 1'b0; 
reg_reg <= 1'b0; 
reg_r <= 1'b0; 
reg_numbit <= 1'b0; 
reg_e <= 1'b0; 
reg_acc <= 1'b0; 
reg_sc <= 1'b0;
reg_ec <= 1'b0;
reg_mc <= 1'b0;
reg_sb <= 1'b0;
reg_eb <= 1'b0;
reg_mb <= 1'b0;
reg_sa <= 1'b0;
reg_ea <= 1'b0;
reg_ma <= 1'b0;
reg_sq <= 1'b0;
reg_eq <= 1'b0;
reg_ss <= 1'b0;
reg_es <= 1'b0;
reg_ms <= 1'b0;
reg_st <= 1'b0;
reg_et <= 1'b0;
reg_sp <= 1'b0;
reg_ep <= 1'b0;
reg_es0 <= 1'b0;
reg_ss0 <= 1'b0;

sr_res <= 2'b00;
sr_mq <= 2'b00;
sr_mt <= 2'b00;
sr_mp <= 2'b00;

ssr_ms0 <= 3'b000;
alu1 <= 3'b000;
alu2 <= 3'b000;
counterii <= 3'b000;


	if (reset)
		begin
		nextstate <= S0;
		end
	else
	case(state)
	
	S0: 
		begin
		if (!start)  nextstate <= S0;
		else nextstate <= S1;
		end
	S1: 
		begin
		mux2 <= 3'b010;
		reg_sum <= 1'b1;
		rf_wa <= 6'b100010;
		rf_we <= 1'b1;
		mux14 <= 2'b11;	
		mux21 <= 2'b01;
		sr_res <= 2'b01;
		mux22 <= 1'b0;
		reg_i <= 1'b1;
		nextstate <= S2;
		end
	S2:
		begin
		case (mode)
		3'b000: nextstate <= S3;
		3'b001: nextstate <= S13;
		3'b010: nextstate <= S42;
		3'b011: nextstate <= S19;
		3'b100: nextstate <= S49;
		default: nextstate <= S43;
		endcase
		end
	S3:
		begin
		reg_currterm <= 1'b1;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		rf_rab <= 6'b100010;
		rf_reb <= 1'b1;
		mux15 <= 1'b0;
		mux3 <= 3'b010;
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux14 <= 2'b11;
		reg_index <= 1'b1;
		mux13 <= 3'b100;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		sr_res <= 2'b01;
		mux20 <= 2'b10;
		alu1 <= 3'b111;
		mux8 <= 3'b100;
		mux21 <= 2'b00;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		nextstate <= S4;
		end
	S4:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		sr_res <= 2'b10;
		nextstate <= S5;
		end
	S5:
		begin
		if (mq47 == 1'b1) nextstate <= S6;
		else nextstate <= S7;
		end
	S6:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		nextstate <= S7;
		end
	S7:
		begin
		mux23 <= 1'b1;
		rf_wa <= 6'b100010;
		rf_we <= 1'b1;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		nextstate <= S8;
		end
	S8:
		begin
		rf_rab <= 6'b100010;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		mux15 <= 1'b0;
		nextstate <= S9; 
		end
	S9:
		begin
		reg_sq <= 1'b1;
		mux16 <=1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		nextstate <= S10;
		end
	S10:
		begin
		if (mq47 == 1'b1) nextstate <= S11;
		else nextstate <= S12;
		end
	S11:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		nextstate <= S12;
		end
	S12:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		nextstate <= S93;
		end
	S13:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b011;
		mux15 <= 1'b0;
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		rf_rab <= 6'b100010;
		rf_reb <= 1'b1;
		mux14 <= 2'b10;
		reg_index <= 1'b1;
		mux13 <= 3'b101;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		sr_res <= 2'b10;
		nextstate <= S14;
		end
	S14:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		sr_res <= 2'b01;
		alu1 <= 3'b111;
		mux20 <= 2'b10;
		mux21 <= 2'b00;
		mux8 <= 3'b100;
		nextstate <= S15;
		end
	S15:
		begin
		if (mq47 == 1'b1) nextstate <= S16;
		else nextstate <= S17;
		end
	S16:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		nextstate <= S17;
		end
	S17:
		begin
		mux23 <= 1'b1;
		rf_wa <= 6'b100010;
		rf_we <= 1'b1;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		nextstate <= S18;
		end
	S18:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		mux14 <= 2'b01;
		nextstate <= S93;
		end
	S19:
		begin
		reg_currterm <= 1'b1;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		rf_rab <= 6'b100010;
		rf_reb <= 1'b1;
		mux15 <= 1'b0;
		mux3 <= 3'b010;
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux14 <= 2'b11;
		reg_index <= 1'b1;
		mux13 <= 3'b100;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		sr_res <= 2'b01;
		mux20 <= 2'b10;
		alu1 <= 3'b111;
		mux8 <= 3'b100;
		mux21 <= 2'b00;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		nextstate <= S20;
		end
	S20:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		sr_res <= 2'b10;
		nextstate <= S21;
		end
	S21:
		begin
		if (mq47 == 1'b1) nextstate <= S22;
		else nextstate <= S23;
		end
	S22:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		nextstate <= S23;
		end
	S23:
		begin
		mux23 <= 1'b1;
		rf_wa <= 6'b100010;
		rf_we <= 1'b1;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		nextstate <= S24;
		end
	S24:
		begin
		rf_rab <= 6'b100010;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		mux15 <= 1'b0;
		nextstate <= S25; 
		end
	S25:
		begin
		reg_sq <= 1'b1;
		mux16 <=1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		nextstate <= S26;
		end
	S26:
		begin
		if (mq47 == 1'b1) nextstate <= S27;
		else nextstate <= S28;
		end
	S27:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		nextstate <= S28;
		end
	S28:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		nextstate <= S93a;
		end
	S29:
		begin
		reg_reg <= 1'b1;
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		mux14 <= 2'b01;
		reg_currterm <= 1'b1;
		mux3 <= 3'b011;
		reg_index <= 1'b1;
		mux13 <= 3'b101;
		reg_i <= 1'b1;
		mux22 <= 1'b0;
		nextstate <= S30;
		end
	S30:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b010;
		nextstate <= S93b;
		end
	S31:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b000;
		nextstate <= S32;
		end
		
	S32:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b110;
		nextstate <= S33;
		end
	S33:
		begin
		reg_ss <= 1'b1;
		reg_es <= 1'b1;
		reg_ms <= 1'b1;
		mux4 <= 2'b10;
		reg_st <= 1'b1;
		reg_et <= 1'b1;
		sr_mt <= 2'b01;
		mux5 <= 1'b1;
		counterii <= 3'b100;
		nextstate <= S34;
		end
	S34:
		begin
		reg_r <= 1'b1;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		alu1 <= 3'b110;
		nextstate <= S91;
		end
	S35:
		begin
		ssr_ms0 <= 3'b100;
		sr_mt <= 2'b11;
		counterii <= 3'b011;
		nextstate <= S37;
		end
	S36:
		begin
		ssr_ms0 <= 3'b101;
		sr_mt <= 2'b11;
		counterii <= 3'b011;
		reg_ms <= 1'b1;
		mux4 <= 2'b01;
		nextstate <= S37;
		end
	S37:
		begin
		reg_es0 <= 1'b1;
		mux8 <= 3'b011;
		mux9 <= 3'b010;
		mux11 <= 1'b1;
		alu1 <= 3'b110;
		if (!msb) nextstate <= S34;
		else nextstate <= S38;
		end
	S38:
		begin
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux9 <= 3'b100;
		mux11 <= 1'b1;
		alu1 <= 3'b101;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b11;
		if (ms0_23 == 1) nextstate <= S41;
		else nextstate <= S39;
		end
	S39:
		begin
		reg_e <= 1'b1;
		nextstate <= S40;
		end
	S40:
		begin
		ssr_ms0 <= 3'b001;
		mux12 <= 2'b01;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux9 <= 3'b101;
		alu1 <= 3'b110;
		mux11 <= 1'b1;
		nextstate <= S41;
		end
	S41:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b011;
		nextstate <= S89;
		end
	S42:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b010;
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		mux14 <= 2'b01;
		reg_index <= 1'b1;
		mux13 <= 3'b011;
		reg_i <= 1'b1;
		mux22 <= 1'b1;
		reg_currterm <= 1'b1;
		mux3 <= 3'b011;
		nextstate <= S90;
		end
	S43:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b010;
		reg_index <= 1'b1;
		mux13 <= 3'b011;
		reg_i <= 1'b1;
		mux22 <= 1'b1;
		rf_rab <= 6'b100010;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		rf_raa <= 6'b100011;
		rf_rea <= 1'b1;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		reg_currterm <= 1'b1;
		mux3 <= 3'b011;
		nextstate <= S44;
		end
	S44:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		nextstate <= S45;
		end
	S45:
		begin
		if (mq47 == 1'b1) nextstate <= S46;
		else nextstate <= S47;
		end
	S46:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		nextstate <= S47;
		end
	S47:
		begin
		mux23 <= 1'b0;
		rf_wa <= 6'b100010;
		rf_we <= 1'b1;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		nextstate <= S48;
		end
	S48:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		nextstate <= S93;
		end
	S49:
		begin
		reg_sum <= 1'b1;
		mux2 <= 2'b10;
		reg_index <= 1'b1;
		mux13 <= 3'b011;
		reg_i <= 1'b1;
		mux22 <= 1'b1;
		sr_res <= 2'b01;
		mux21 <= 2'b10;
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux14 <= 2'b10;
		reg_currterm <= 1'b1;
		mux3 <= 3'b011;
		nextstate <= S50;
		end
	S50:
		begin
		nextstate <= S93c;
		end
	S51:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b100;
		rf_raa <= 6'b100001;
		rf_rea <= 1'b1;
		nextstate <= S89;
		end
	S52:
		begin
		if (!sumor) nextstate <= S53;
		else nextstate <= S54;
		end
	S53:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b000;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		rf_rab <= 6'b100001;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		mux15 <= 1'b0;
		nextstate <= S55;
		end
	S54:
		begin
		reg_ss <= 1'b1;
		reg_es <= 1'b1;
		reg_ms <= 1'b1;
		mux4 <= 2'b10;
		reg_st <= 1'b1;
		reg_et <= 1'b1;
		sr_mt <= 2'b01;
		mux5 <= 1'b1;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		rf_rab <= 6'b100001;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		mux15 <= 1'b0;
		if (comp1_g == 1) nextstate <= S57;
		else nextstate <= S56;
		end
	S55:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		nextstate <= S58;
		end
	S56:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		reg_numbit <= 1'b1;
		mux8 <= 3'b010;
		mux9 <= 3'b011;
		alu1 <= 3'b110;
		nextstate <= S59;
		end
	S57:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		reg_numbit <= 1'b1;
		mux8 <= 3'b011;
		mux9 <= 3'b010;
		alu1 <= 3'b110;
		nextstate <= S60;
		end
	S58:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		if (mq47 == 1) nextstate <= S61;
		else nextstate <= S66;
		end
	S59:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		reg_ms <= 1'b1;
		mux10 <= 1'b1;
		mux4 <= 2'b00;
		reg_es0 <= 1'b1;
		mux11 <= 1'b0;
		mux7 <= 1'b0;
		if (mq47 == 1 && stxor == 0) nextstate <= S62;
		else if (mq47 == 0 && stxor == 0) nextstate <= S63;
		else if (mq47 == 1 && stxor == 1) nextstate <= S64;
		else nextstate <= S65;
		end
	S60:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		sr_mt <= 2'b01;
		mux10 <= 1'b0;
		mux5 <= 1'b0;
		reg_es0 <= 1'b1;
		mux11 <= 1'b0;
		mux7 <= 1'b1;
		if (mq47 == 1 && stxor == 0) nextstate <= S62;
		else if (mq47 == 0 && stxor == 0) nextstate <= S63;
		else if (mq47 == 1 && stxor == 1) nextstate <= S64;
		else nextstate <= S65;
		end
	S61:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		nextstate <= S66;
		end
	S62:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b10;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		alu1 <= 3'b101;
		nextstate <= S67;
		end
	S63:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b10;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		alu1 <= 3'b101;
		nextstate <= S67;
		end
	S64:
		begin
		ssr_ms0 <= 3'b001;
		alu1 <= 3'b110;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		if (st == 1) nextstate <= S68;
		else nextstate <= S69;
		end
	S65:
		begin
		ssr_ms0 <= 3'b001;
		alu1 <= 3'b110;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		if (st == 1) nextstate <= S68;
		else nextstate <= S69;
		end
	S66:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (mp47 == 1) nextstate <= S70;
		else nextstate <= S87;
		end
	S67:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_24 == 1 && mp47 ==1 ) nextstate <= S71;
		else if (ms0_24 == 1 && mp47 ==0 ) nextstate <= S72;
		else if (ms0_24 == 0 && mp47 ==1 ) nextstate <= S73;
		else nextstate <= S82;
		end
	S68:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_63 == 1 && mp47 ==1 ) nextstate <= S76;
		else if (ms0_63 == 1 && mp47 ==0 ) nextstate <= S77;
		else if (ms0_63 == 0 && mp47 ==1 ) nextstate <= S74;
		else nextstate <= S75;
		end
	S69:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_63 == 1 && mp47 ==1 ) nextstate <= S80;
		else if (ms0_63 == 1 && mp47 ==0 ) nextstate <= S81;
		else if (ms0_63 == 0 && mp47 ==1 ) nextstate <= S78;
		else nextstate <= S79;
		end
	S70:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S87;
		end
	S71:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		ssr_ms0 <= 3'b011;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux11 <= 1'b1;
		alu1 <= 3'b111;
		nextstate <= S82;
		end
	S72:
		begin
		ssr_ms0 <= 3'b011;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux11 <= 1'b1;
		alu1 <= 3'b111;
		nextstate <= S82;
		end
	S73:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S82;
		end
	S74:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		nextstate <= S83;
		end
	S75:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		nextstate <= S83;
		end
	S76:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83;
		end
	S77:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83;
		end
	S78:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		nextstate <= S83;
		end
	S79:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		nextstate <= S83;
		end
	S80:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S83;
		end
	S81:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83;
		end
	S82:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		nextstate <= S84;
		end
	S83:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		reg_e <= 1'b1;
		nextstate <= S85;
		end
	S84:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b011;
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93;
		end
	S85:
		begin
		ssr_ms0 <= 3'b001;
		mux12 <= 2'b01;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux9 <= 3'b101;
		alu1 <= 3'b110;
		mux11 <= 1'b1;
		nextstate <= S86;
		end
	S86:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b011;
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93;
		end
	S87:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		nextstate <= S88;
		end
	S88:
		begin
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93;
		end
	S89:
		begin
		reg_acc <= 1'b1;
		mux1 <= 2'b01;
		nextstate <= S0;
		end
	S90:
		begin
		nextstate <= S93;
		end

	S91:
		begin
		if (r31==1'b1) nextstate <= S35;
		else nextstate <= S36;
		end
	S93:
		begin
		if (comp2_g ==1) nextstate <= S52;
		else nextstate <= S89;
		end
		
	S52a:
		begin
		if (!sumor) nextstate <= S53a;
		else nextstate <= S54a;
		end
	S53a:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b000;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		rf_rab <= 6'b100001;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		mux15 <= 1'b0;
		nextstate <= S55a;
		end
	S54a:
		begin
		reg_ss <= 1'b1;
		reg_es <= 1'b1;
		reg_ms <= 1'b1;
		mux4 <= 2'b10;
		reg_st <= 1'b1;
		reg_et <= 1'b1;
		sr_mt <= 2'b01;
		mux5 <= 1'b1;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		rf_rab <= 6'b100001;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		mux15 <= 1'b0;
		if (comp1_g == 1) nextstate <= S57a;
		else nextstate <= S56a;
		end
	S55a:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		nextstate <= S58a;
		end
	S56a:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		reg_numbit <= 1'b1;
		mux8 <= 3'b010;
		mux9 <= 3'b011;
		alu1 <= 3'b110;
		nextstate <= S59a;
		end
	S57a:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		reg_numbit <= 1'b1;
		mux8 <= 3'b011;
		mux9 <= 3'b010;
		alu1 <= 3'b110;
		nextstate <= S60a;
		end
	S58a:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		if (mq47 == 1) nextstate <= S61a;
		else nextstate <= S66a;
		end
	S59a:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		reg_ms <= 1'b1;
		mux10 <= 1'b1;
		mux4 <= 2'b00;
		reg_es0 <= 1'b1;
		mux11 <= 1'b0;
		mux7 <= 1'b0;
		if (mq47 == 1 && stxor == 0) nextstate <= S62a;
		else if (mq47 == 0 && stxor == 0) nextstate <= S63a;
		else if (mq47 == 1 && stxor == 1) nextstate <= S64a;
		else nextstate <= S65a;
		end
	S60a:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		sr_mt <= 2'b01;
		mux10 <= 1'b0;
		mux5 <= 1'b0;
		reg_es0 <= 1'b1;
		mux11 <= 1'b0;
		mux7 <= 1'b1;
		if (mq47 == 1 && stxor == 0) nextstate <= S62a;
		else if (mq47 == 0 && stxor == 0) nextstate <= S63a;
		else if (mq47 == 1 && stxor == 1) nextstate <= S64a;
		else nextstate <= S65a;
		end
	S61a:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		nextstate <= S66a;
		end
	S62a:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b10;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		alu1 <= 3'b101;
		nextstate <= S67a;
		end
	S63a:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b10;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		alu1 <= 3'b101;
		nextstate <= S67a;
		end
	S64a:
		begin
		ssr_ms0 <= 3'b001;
		alu1 <= 3'b110;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		if (st == 1) nextstate <= S68a;
		else nextstate <= S69a;
		end
	S65a:
		begin
		ssr_ms0 <= 3'b001;
		alu1 <= 3'b110;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		if (st == 1) nextstate <= S68a;
		else nextstate <= S69a;
		end
	S66a:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (mp47 == 1) nextstate <= S70a;
		else nextstate <= S87a;
		end
	S67a:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_24 == 1 && mp47 ==1 ) nextstate <= S71a;
		else if (ms0_24 == 1 && mp47 ==0 ) nextstate <= S72a;
		else if (ms0_24 == 0 && mp47 ==1 ) nextstate <= S73a;
		else nextstate <= S82a;
		end
	S68a:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_63 == 1 && mp47 ==1 ) nextstate <= S76a;
		else if (ms0_63 == 1 && mp47 ==0 ) nextstate <= S77a;
		else if (ms0_63 == 0 && mp47 ==1 ) nextstate <= S74a;
		else nextstate <= S75a;
		end
	S69a:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_63 == 1 && mp47 ==1 ) nextstate <= S80a;
		else if (ms0_63 == 1 && mp47 ==0 ) nextstate <= S81a;
		else if (ms0_63 == 0 && mp47 ==1 ) nextstate <= S78a;
		else nextstate <= S79a;
		end
	S70a:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S87a;
		end
	S71a:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		ssr_ms0 <= 3'b011;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux11 <= 1'b1;
		alu1 <= 3'b111;
		nextstate <= S82a;
		end
	S72a:
		begin
		ssr_ms0 <= 3'b011;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux11 <= 1'b1;
		alu1 <= 3'b111;
		nextstate <= S82a;
		end
	S73a:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S82a;
		end
	S74a:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		nextstate <= S83a;
		end
	S75a:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		nextstate <= S83a;
		end
	S76a:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83a;
		end
	S77a:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83a;
		end
	S78a:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		nextstate <= S83a;
		end
	S79a:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		nextstate <= S83a;
		end
	S80a:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S83a;
		end
	S81a:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83a;
		end
	S82a:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		nextstate <= S84a;
		end
	S83a:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		reg_e <= 1'b1;
		nextstate <= S85a;
		end
	S84a:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b011;
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93a;
		end
	S85a:
		begin
		ssr_ms0 <= 3'b001;
		mux12 <= 2'b01;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux9 <= 3'b101;
		alu1 <= 3'b110;
		mux11 <= 1'b1;
		nextstate <= S86a;
		end
	S86a:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b011;
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93a;
		end
	S87a:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		nextstate <= S88a;
		end
	S88a:
		begin
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93a;
		end
	S93a:
		begin
		if (comp2_g ==1) nextstate <= S52a;
		else nextstate <= S29;
		end

	S52b:
		begin
		if (!sumor) nextstate <= S53b;
		else nextstate <= S54b;
		end
	S53b:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b000;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		rf_rab <= 6'b100001;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		mux15 <= 1'b0;
		nextstate <= S55b;
		end
	S54b:
		begin
		reg_ss <= 1'b1;
		reg_es <= 1'b1;
		reg_ms <= 1'b1;
		mux4 <= 2'b10;
		reg_st <= 1'b1;
		reg_et <= 1'b1;
		sr_mt <= 2'b01;
		mux5 <= 1'b1;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		rf_rab <= 6'b100001;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		mux15 <= 1'b0;
		if (comp1_g == 1) nextstate <= S57b;
		else nextstate <= S56b;
		end
	S55b:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		nextstate <= S58b;
		end
	S56b:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		reg_numbit <= 1'b1;
		mux8 <= 3'b010;
		mux9 <= 3'b011;
		alu1 <= 3'b110;
		nextstate <= S59b;
		end
	S57b:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		reg_numbit <= 1'b1;
		mux8 <= 3'b011;
		mux9 <= 3'b010;
		alu1 <= 3'b110;
		nextstate <= S60b;
		end
	S58b:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		if (mq47 == 1) nextstate <= S61b;
		else nextstate <= S66b;
		end
	S59b:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		reg_ms <= 1'b1;
		mux10 <= 1'b1;
		mux4 <= 2'b00;
		reg_es0 <= 1'b1;
		mux11 <= 1'b0;
		mux7 <= 1'b0;
		if (mq47 == 1 && stxor == 0) nextstate <= S62b;
		else if (mq47 == 0 && stxor == 0) nextstate <= S63b;
		else if (mq47 == 1 && stxor == 1) nextstate <= S64b;
		else nextstate <= S65b;
		end
	S60b:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		sr_mt <= 2'b01;
		mux10 <= 1'b0;
		mux5 <= 1'b0;
		reg_es0 <= 1'b1;
		mux11 <= 1'b0;
		mux7 <= 1'b1;
		if (mq47 == 1 && stxor == 0) nextstate <= S62b;
		else if (mq47 == 0 && stxor == 0) nextstate <= S63b;
		else if (mq47 == 1 && stxor == 1) nextstate <= S64b;
		else nextstate <= S65b;
		end
	S61b:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		nextstate <= S66b;
		end
	S62b:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b10;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		alu1 <= 3'b101;
		nextstate <= S67b;
		end
	S63b:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b10;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		alu1 <= 3'b101;
		nextstate <= S67b;
		end
	S64b:
		begin
		ssr_ms0 <= 3'b001;
		alu1 <= 3'b110;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		if (st == 1) nextstate <= S68b;
		else nextstate <= S69b;
		end
	S65b:
		begin
		ssr_ms0 <= 3'b001;
		alu1 <= 3'b110;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		if (st == 1) nextstate <= S68b;
		else nextstate <= S69b;
		end
	S66b:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (mp47 == 1) nextstate <= S70b;
		else nextstate <= S87b;
		end
	S67b:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_24 == 1 && mp47 ==1 ) nextstate <= S71b;
		else if (ms0_24 == 1 && mp47 ==0 ) nextstate <= S72b;
		else if (ms0_24 == 0 && mp47 ==1 ) nextstate <= S73b;
		else nextstate <= S82b;
		end
	S68b:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_63 == 1 && mp47 ==1 ) nextstate <= S76b;
		else if (ms0_63 == 1 && mp47 ==0 ) nextstate <= S77b;
		else if (ms0_63 == 0 && mp47 ==1 ) nextstate <= S74b;
		else nextstate <= S75b;
		end
	S69b:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_63 == 1 && mp47 ==1 ) nextstate <= S80b;
		else if (ms0_63 == 1 && mp47 ==0 ) nextstate <= S81b;
		else if (ms0_63 == 0 && mp47 ==1 ) nextstate <= S78b;
		else nextstate <= S79b;
		end
	S70b:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S87b;
		end
	S71b:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		ssr_ms0 <= 3'b011;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux11 <= 1'b1;
		alu1 <= 3'b111;
		nextstate <= S82b;
		end
	S72b:
		begin
		ssr_ms0 <= 3'b011;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux11 <= 1'b1;
		alu1 <= 3'b111;
		nextstate <= S82b;
		end
	S73b:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S82b;
		end
	S74b:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		nextstate <= S83b;
		end
	S75b:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		nextstate <= S83b;
		end
	S76b:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83b;
		end
	S77b:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83b;
		end
	S78b:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		nextstate <= S83b;
		end
	S79b:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		nextstate <= S83b;
		end
	S80b:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S83b;
		end
	S81b:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83b;
		end
	S82b:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		nextstate <= S84b;
		end
	S83b:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		reg_e <= 1'b1;
		nextstate <= S85b;
		end
	S84b:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b011;
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93b;
		end
	S85b:
		begin
		ssr_ms0 <= 3'b001;
		mux12 <= 2'b01;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux9 <= 3'b101;
		alu1 <= 3'b110;
		mux11 <= 1'b1;
		nextstate <= S86b;
		end
	S86b:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b011;
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93b;
		end
	S87b:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		nextstate <= S88b;
		end
	S88b:
		begin
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93b;
		end
	S93b:
		begin
		if (comp2_g ==1) nextstate <= S52b;
		else nextstate <= S31;
		end
	
	S52c:
		begin
		if (!sumor) nextstate <= S53c;
		else nextstate <= S54c;
		end
	S53c:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b000;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		rf_rab <= 6'b100001;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		mux15 <= 1'b0;
		nextstate <= S55c;
		end
	S54c:
		begin
		reg_ss <= 1'b1;
		reg_es <= 1'b1;
		reg_ms <= 1'b1;
		mux4 <= 2'b10;
		reg_st <= 1'b1;
		reg_et <= 1'b1;
		sr_mt <= 2'b01;
		mux5 <= 1'b1;
		rf_raa <= 6'b100010;
		rf_rea <= 1'b1;
		reg_sc <= 1'b1;
		reg_ec <= 1'b1;
		reg_mc <= 1'b1;
		rf_rab <= 6'b100001;
		rf_reb <= 1'b1;
		reg_sb <= 1'b1;
		reg_eb <= 1'b1;
		reg_mb <= 1'b1;
		mux15 <= 1'b0;
		if (comp1_g == 1) nextstate <= S57c;
		else nextstate <= S56c;
		end
	S55c:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		nextstate <= S58c;
		end
	S56c:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		reg_numbit <= 1'b1;
		mux8 <= 3'b010;
		mux9 <= 3'b011;
		alu1 <= 3'b110;
		nextstate <= S59c;
		end
	S57c:
		begin
		reg_sq <= 1'b1;
		mux16 <= 1'b1;
		reg_eq <= 1'b1;
		mux17 <= 3'b101;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mq <= 2'b01;
		mux19 <= 1'b1;
		rf_reb <= 1'b1;
		mux15 <= 1'b1;
		reg_sa <= 1'b1;
		reg_ea <= 1'b1;
		reg_ma <= 1'b1;
		reg_numbit <= 1'b1;
		mux8 <= 3'b011;
		mux9 <= 3'b010;
		alu1 <= 3'b110;
		nextstate <= S60c;
		end
	S58c:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		if (mq47 == 1) nextstate <= S61c;
		else nextstate <= S66c;
		end
	S59c:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		reg_ms <= 1'b1;
		mux10 <= 1'b1;
		mux4 <= 2'b00;
		reg_es0 <= 1'b1;
		mux11 <= 1'b0;
		mux7 <= 1'b0;
		if (mq47 == 1 && stxor == 0) nextstate <= S62c;
		else if (mq47 == 0 && stxor == 0) nextstate <= S63c;
		else if (mq47 == 1 && stxor == 1) nextstate <= S64c;
		else nextstate <= S65c;
		end
	S60c:
		begin
		reg_sp <= 1'b1;
		mux16 <= 1'b0;
		reg_ep <= 1'b1;
		mux17 <= 3'b100;
		mux18 <= 1'b1;
		alu2 <= 3'b101;
		sr_mp <= 2'b01;
		mux19 <= 1'b0;
		sr_mt <= 2'b01;
		mux10 <= 1'b0;
		mux5 <= 1'b0;
		reg_es0 <= 1'b1;
		mux11 <= 1'b0;
		mux7 <= 1'b1;
		if (mq47 == 1 && stxor == 0) nextstate <= S62c;
		else if (mq47 == 0 && stxor == 0) nextstate <= S63c;
		else if (mq47 == 1 && stxor == 1) nextstate <= S64c;
		else nextstate <= S65c;
		end
	S61c:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		nextstate <= S66c;
		end
	S62c:
		begin
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b10;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		alu1 <= 3'b101;
		nextstate <= S67c;
		end
	S63c:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b10;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		alu1 <= 3'b101;
		nextstate <= S67c;
		end
	S64c:
		begin
		ssr_ms0 <= 3'b001;
		alu1 <= 3'b110;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		sr_mq <= 2'b11;
		mux17 <= 3'b000;
		alu2 <= 3'b111;
		reg_eq <= 1'b1;
		if (st == 1) nextstate <= S68c;
		else nextstate <= S69c;
		end
	S65c:
		begin
		ssr_ms0 <= 3'b001;
		alu1 <= 3'b110;
		mux8 <= 3'b001;
		mux9 <= 3'b001;
		mux12 <= 2'b10;
		if (st == 1) nextstate <= S68c;
		else nextstate <= S69c;
		end
	S66c:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (mp47 == 1) nextstate <= S70c;
		else nextstate <= S87c;
		end
	S67c:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_24 == 1 && mp47 ==1 ) nextstate <= S71c;
		else if (ms0_24 == 1 && mp47 ==0 ) nextstate <= S72c;
		else if (ms0_24 == 0 && mp47 ==1 ) nextstate <= S73c;
		else nextstate <= S82c;
		end
	S68c:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_63 == 1 && mp47 ==1 ) nextstate <= S76c;
		else if (ms0_63 == 1 && mp47 ==0 ) nextstate <= S77c;
		else if (ms0_63 == 0 && mp47 ==1 ) nextstate <= S74c;
		else nextstate <= S75c;
		end
	S69c:
		begin
		rf_wa <= 6'b100001;
		rf_we <= 1'b1;
		mux23 <= 1'b0;
		mux17 <= 3'b000;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		mux14 <= 2'b00;
		if (ms0_63 == 1 && mp47 ==1 ) nextstate <= S80c;
		else if (ms0_63 == 1 && mp47 ==0 ) nextstate <= S81c;
		else if (ms0_63 == 0 && mp47 ==1 ) nextstate <= S78c;
		else nextstate <= S79c;
		end
	S70c:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S87c;
		end
	S71c:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		ssr_ms0 <= 3'b011;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux11 <= 1'b1;
		alu1 <= 3'b111;
		nextstate <= S82c;
		end
	S72c:
		begin
		ssr_ms0 <= 3'b011;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux11 <= 1'b1;
		alu1 <= 3'b111;
		nextstate <= S82c;
		end
	S73c:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S82c;
		end
	S74c:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		nextstate <= S83c;
		end
	S75c:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		nextstate <= S83c;
		end
	S76c:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83c;
		end
	S77c:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83c;
		end
	S78c:
		begin
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		nextstate <= S83c;
		end
	S79c:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b00;
		nextstate <= S83c;
		end
	S80c:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		sr_mp <= 2'b11;
		reg_ep <= 1'b1;
		mux17 <= 3'b001;
		alu2 <= 3'b111;
		nextstate <= S83c;
		end
	S81c:
		begin
		reg_ss0 <= 1'b1;
		mux6 <= 2'b01;
		ssr_ms0 <= 3'b001;
		mux8 <= 3'b100;
		mux9 <= 3'b000;
		mux12 <= 2'b10;
		mux20 <= 2'b11;
		alu1 <= 3'b110;
		nextstate <= S83c;
		end
	S82c:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		nextstate <= S84c;
		end
	S83c:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		reg_e <= 1'b1;
		nextstate <= S85c;
		end
	S84c:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b011;
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93c;
		end
	S85c:
		begin
		ssr_ms0 <= 3'b001;
		mux12 <= 2'b01;
		reg_es0 <= 1'b1;
		mux8 <= 3'b000;
		mux9 <= 3'b101;
		alu1 <= 3'b110;
		mux11 <= 1'b1;
		nextstate <= S86c;
		end
	S86c:
		begin
		reg_sum <= 1'b1;
		mux2 <= 3'b011;
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93c;
		end
	S87c:
		begin
		reg_currterm <= 1'b1;
		mux3 <= 3'b100;
		mux17 <= 3'b001;
		mux18 <= 1'b0;
		alu2 <= 3'b110;
		nextstate <= S88c;
		end
	S88c:
		begin
		reg_index <= 1'b1;
		mux13 <= 3'b110;
		nextstate <= S93c;
		end
	S93c:
		begin
		if (comp2_g ==1) nextstate <= S52c;
		else nextstate <= S51;
		end
	endcase
end
endmodule
	