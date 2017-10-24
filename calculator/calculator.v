`include "./FSM.v"
`include "./add6.v"
`include "./ALU32.v"
`include "./Bshifter.v"
`include "./Comparator.v"
`include "./counter.v"
`include "./mult32.v"
`include "./mux2.v"
`include "./mux4.v"
`include "./mux8.v"
`include "./priencoder.v"
`include "./register.v"
`include "./reg1.v"
`include "./reg6.v"
`include "./RF.v"
`include "./SR.v"
`include "./SSR.v"
`include "./sumor.v"
`include "./mux2_6.v"
`include "./mux8_6.v"
`include "./mux4_64.v"
`include "./xor1bit.v"
`include "./Bshifterright.v"


module calculator(clk,start,reset,mode, calculator_input, n_input, regacc_out, state_out, Coutadd, Coutone, Couttwo, 
m14_out, alutwo_out, m17_out, m18_out, srmq_out, regec_out, regeb_out, rf_aout, regi_out, regcurrterm_out, regsum_out, 
srmt_out, regms_out, reges_out, reget_out, regss0_out, reges0_out, ssrms0_out, aluone_out, regreg_out, rege_out);

input clk,start,reset;
input[2:0] mode;
input[31:0] calculator_input, n_input;

output[31:0] regacc_out;
output[8:0] state_out;
output Coutadd, Coutone, Couttwo;

output regss0_out;
output[5:0] regi_out;
output[31:0] m14_out, alutwo_out, m17_out, m18_out, regec_out, regeb_out, rf_aout, regcurrterm_out, regsum_out,	
	srmt_out, regms_out, reges_out, reget_out, reges0_out, aluone_out, regreg_out, rege_out ;
output[63:0] srmq_out, ssrms0_out;

wire Coutadd, Coutone, Couttwo;
//reg[31:0] regacc_out;
//reg[8:0] state_out;

wire mux5, mux7, mux10, mux11, mux15, mux16, mux18, mux19, mux22, mux23;
wire[1:0] mux1, mux4, mux6, mux12, mux14, mux20, mux21;
wire[2:0] mux2, mux3, mux8, mux9, mux13, mux17;
wire rf_we, rf_rea, rf_reb;
wire[5:0] rf_wa, rf_raa, rf_rab;
wire reg_sum, reg_i, reg_currterm, reg_index, reg_reg, reg_r, reg_numbit, reg_e, reg_acc, reg_res;
wire reg_sc, reg_ec, reg_mc, reg_sb, reg_eb, reg_mb, reg_sa, reg_ea, reg_ma;
wire reg_sq, reg_eq, reg_ss, reg_es, reg_ms, reg_st, reg_et, reg_sp, reg_ep;
wire reg_es0, reg_ss0;
wire[1:0] sr_res, sr_mq, sr_mt, sr_mp;
wire[2:0] ssr_ms0;
wire[2:0] alu1, alu2;
wire[2:0] counterii;
wire[8:0] state_out;


wire[31:0] m1_out, m2_out, m3_out, m4_out, m5_out, m6_out, m7_out, m8_out, m9_out, m10_out, m11_out, m14_out, m16_out, m17_out, m18_out, m19_out,
	m20_out, m21_out, m23_out;
wire[31:0] regacc_out, regreg_out, regsum_out, regcurrterm_out, reges_out,reget_out, regms_out, regnumbit_out, reges0_out, regr_out, rege_out,
	regea_out, regeb_out, regec_out, regma_out, regmb_out, regmc_out, regep_out, regeq_out,
	srmt_out, regres_out;
wire[31:0] aluone_out, alutwo_out;
wire[31:0] bs2_out,bs1_out;
wire[31:0] rf_aout, rf_bout;

wire sumorrr_out, comp1_out, comp2_out,
	regss_out, regst_out, regss0_out, regsa_out, regsb_out, regsc_out, regsp_out, regsq_out,
	xor3_out, xor2_out, xor1_out;

wire[63:0] mult1_out, ssrms0_out, mult2_out, srmp_out, srmq_out, m12_out;

wire[5:0] count_out,pe_out,
	m22_out, m13_out, m15_out,
	regi_out, regindex_out,
	add_out;

//mux
mux4_1 m1(.selector(mux1), .data_in_00(32'b0), .data_in_01(regsum_out), .data_in_10({regss0_out,reges0_out[7:0],ssrms0_out[22:0]}), .data_in_11(32'b0), .data_out(m1_out));

mux8_1 m2(.selector(mux2), .data_in_000(regcurrterm_out), .data_in_001(32'h3f800000), .data_in_010(32'b0), .data_in_011({regss0_out,reges0_out[7:0],ssrms0_out[22:0]}),
	.data_in_100(rf_aout), .data_in_101(regacc_out), .data_in_110(regreg_out), .data_in_111(32'b0), .data_out(m2_out));

mux8_1 m3(.selector(mux3), .data_in_000(regsum_out), .data_in_001(32'b0), .data_in_010(rf_aout), .data_in_011(32'h3f800000),
	.data_in_100({regsp_out,alutwo_out[7:0],srmp_out[45:23]}), .data_in_101(32'b0), .data_in_110(32'b0), .data_in_111(32'b0), .data_out(m3_out));

mux4_1 m4(.selector(mux4), .data_in_00(bs2_out), .data_in_01(regr_out), .data_in_10({8'b0, 1'b1, regsum_out[22:0]}), .data_in_11(32'b0), .data_out(m4_out));

mux2_1 m5(.selector(mux5), .data_in_0(bs2_out), .data_in_1({8'b0, 1'b1, regcurrterm_out[22:0]}), .data_out(m5_out));

mux4_1 m6(.selector(mux6), .data_in_00({31'b0,1'b1}), .data_in_01(32'b0), .data_in_10({31'b0,regst_out}), .data_in_11({31'b0,xor1_out}), .data_out(m6_out));

mux2_1 m7(.selector(mux7), .data_in_0(reget_out), .data_in_1(reges_out), .data_out(m7_out));

mux8_1 m8(.selector(mux8), .data_in_000(reges0_out), .data_in_001(regms_out), .data_in_010(reget_out), .data_in_011(reges_out),
	.data_in_100(m20_out), .data_in_101(srmt_out), .data_in_110(32'b0), .data_in_111(32'b0), .data_out(m8_out));

mux8_1 m9(.selector(mux9), .data_in_000(ssrms0_out[31:0]), .data_in_001(srmt_out), .data_in_010(reget_out), .data_in_011(reges_out),
	.data_in_100(32'h7f), .data_in_101(rege_out), .data_in_110(regms_out), .data_in_111(32'b0), .data_out(m9_out));

mux2_1 m10(.selector(mux10), .data_in_0(srmt_out), .data_in_1(regms_out), .data_out(m10_out));

mux2_1 m11(.selector(mux11), .data_in_0(m7_out), .data_in_1(aluone_out), .data_out(m11_out));

mux4_1_64 m12(.selector(mux12), .data_in_00(mult1_out), .data_in_01({32'b0,bs1_out}), .data_in_10({32'b0,aluone_out}), .data_in_11(64'b0), .data_out(m12_out));

mux8_1_6 m13(.selector(mux13), .data_in_000(6'b0), .data_in_001(6'b0), .data_in_010(6'b0), .data_in_011(6'b000001),
	.data_in_100(6'b000011), .data_in_101(6'b000010), .data_in_110(add_out), .data_in_111(6'b0), .data_out(m13_out));

mux4_1 m14(.selector(mux14), .data_in_00({m23_out[0],alutwo_out[7:0],srmq_out[45:23]}), .data_in_01(rf_aout), .data_in_10(32'h3f800000), .data_in_11(calculator_input), .data_out(m14_out));

mux2_1_6 m15(.selector(mux15), .data_in_0(rf_rab), .data_in_1(regindex_out), .data_out(m15_out));

mux2_1 m16(.selector(mux16), .data_in_0({31'b0,regsa_out}), .data_in_1({31'b0,regsc_out}), .data_out(m16_out));

mux8_1 m17(.selector(mux17), .data_in_000(regeq_out), .data_in_001(regep_out), .data_in_010(32'b0), .data_in_011(32'b0),
	.data_in_100(regea_out), .data_in_101(regec_out), .data_in_110(32'b0), .data_in_111(32'b0), .data_out(m17_out));

mux2_1 m18(.selector(mux18), .data_in_0(32'h7f), .data_in_1(regeb_out), .data_out(m18_out));

mux2_1 m19(.selector(mux19), .data_in_0(regma_out), .data_in_1(regmc_out), .data_out(m19_out));

mux4_1 m20(.selector(mux20), .data_in_00(reges0_out), .data_in_01(32'b0), .data_in_10(regres_out), .data_in_11(32'b0), .data_out(m20_out));

mux4_1 m21(.selector(mux21), .data_in_00(aluone_out), .data_in_01({28'b0,4'b1010}), .data_in_10(n_input), .data_in_11(32'b0), .data_out(m21_out));

mux2_1_6 m22(.selector(mux22), .data_in_0(6'b000010), .data_in_1(6'b000001), .data_out(m22_out));

mux2_1 m23(.selector(mux23), .data_in_0({31'b0,regsq_out}), .data_in_1({31'b0,1'b1}), .data_out(m23_out));

//reg1bit
reg1bit regss(.clk(clk), .load(reg_ss), .data_in(regsum_out[31]), .data_out(regss_out));

reg1bit regst(.clk(clk), .load(reg_st), .data_in(regcurrterm_out[31]), .data_out(regst_out));

reg1bit regss0(.clk(clk), .load(reg_ss0), .data_in(m6_out[0]), .data_out(regss0_out));

reg1bit regsc(.clk(clk), .load(reg_sc), .data_in(rf_aout[31]), .data_out(regsc_out));

reg1bit regsb(.clk(clk), .load(reg_sb), .data_in(rf_bout[31]), .data_out(regsb_out));

reg1bit regsa(.clk(clk), .load(reg_sa), .data_in(rf_bout[31]), .data_out(regsa_out));

reg1bit regsp(.clk(clk), .load(reg_sp), .data_in(xor2_out), .data_out(regsp_out));

reg1bit regsq(.clk(clk), .load(reg_sq), .data_in(xor2_out), .data_out(regsq_out));

//reg6bits
reg6 regi(.clk(clk), .load(reg_i), .data_in(m22_out), .data_out(regi_out));

reg6 regindex(.clk(clk), .load(reg_index), .data_in(m13_out), .data_out(regindex_out));

//register
register reges(.clk(clk), .load(reg_es), .data_in({24'b0,regsum_out[30:23]}), .data_out(reges_out));

register reget(.clk(clk), .load(reg_et), .data_in({24'b0,regcurrterm_out[30:23]}), .data_out(reget_out));

register regms(.clk(clk), .load(reg_ms), .data_in(m4_out), .data_out(regms_out));

register regreg(.clk(clk), .load(reg_reg), .data_in(regsum_out), .data_out(regreg_out));

register regacc(.clk(clk), .load(reg_acc), .data_in(m1_out), .data_out(regacc_out));

register regsum(.clk(clk), .load(reg_sum), .data_in(m2_out), .data_out(regsum_out));

register regcurrterm(.clk(clk), .load(reg_currterm), .data_in(m3_out), .data_out(regcurrterm_out));

register regnumbit(.clk(clk), .load(reg_numbit), .data_in(aluone_out), .data_out(regnumbit_out));

register reges0(.clk(clk), .load(reg_es0), .data_in(m11_out), .data_out(reges0_out));

register regr(.clk(clk), .load(reg_r), .data_in(aluone_out), .data_out(regr_out));

register rege(.clk(clk), .load(reg_e), .data_in({26'b0,pe_out}), .data_out(rege_out));

register regec(.clk(clk), .load(reg_ec), .data_in({24'b0,rf_aout[30:23]}), .data_out(regec_out));

register regmc(.clk(clk), .load(reg_mc), .data_in({8'b0,1'b1,rf_aout[22:0]}), .data_out(regmc_out));

register regeb(.clk(clk), .load(reg_eb), .data_in({24'b0,rf_bout[30:23]}), .data_out(regeb_out));

register regmb(.clk(clk), .load(reg_mb), .data_in({8'b0,1'b1,rf_bout[22:0]}), .data_out(regmb_out));

register regea(.clk(clk), .load(reg_ea), .data_in({24'b0,rf_bout[30:23]}), .data_out(regea_out));

register regma(.clk(clk), .load(reg_ma), .data_in({8'b0,1'b1,rf_bout[22:0]}), .data_out(regma_out));

register regep(.clk(clk), .load(reg_ep), .data_in(alutwo_out), .data_out(regep_out));

register regeq(.clk(clk), .load(reg_eq), .data_in(alutwo_out), .data_out(regeq_out));



//SR
SR srmt(.clk(clk), .S(sr_mt), .data_in(m5_out), .data_out(srmt_out)); 

SR srres(.clk(clk), .S(sr_res), .data_in(m21_out), .data_out(regres_out)); 

SR_64 srmp(.clk(clk), .S(sr_mp), .data_in(mult2_out), .data_out(srmp_out)); 

SR_64 srmq(.clk(clk), .S(sr_mq), .data_in(mult2_out), .data_out(srmq_out)); 

//SSR
SSR ssrms0(.clk(clk), .S(ssr_ms0), .data_in(m12_out), .data_out(ssrms0_out), .ii(count_out)); 

//sumorr
sumorr sumorrr( .data_in(regsum_out), .out(sumorrr_out));

//comparator
comparator comp1(.data_in1({24'b0,regsum_out[30:23]}), .data_in2({24'b0,regcurrterm_out[30:23]}), .G(comp1_out));

comparator comp2(.data_in1(regres_out), .data_in2({26'b0,regindex_out}), .G(comp2_out));

//alu1
ALU32 aluone(.data_in1(m8_out), .data_in2(m9_out), .alu_out(aluone_out), .opcode(alu1), .Cout(Coutone));

ALU32 alutwo(.data_in1(m17_out), .data_in2(m18_out), .alu_out(alutwo_out), .opcode(alu2), .Cout(Couttwo));

//mult1
mult32 mult1(.A(regms_out), .B(srmt_out), .Product(mult1_out));

mult32 mult2(.A(regmb_out), .B(m19_out), .Product(mult2_out));

//counter
counter count(.clk(clk), .data_in(6'b010111), .data_out(count_out), .control(counterii));

//BS
Bshifterright bs2(.data_in(m10_out), .data_out(bs2_out), .bits(regnumbit_out));

Bshifterleft bs1(.data_in({8'b0,ssrms0_out[23:0]}), .data_out(bs1_out), .bits(rege_out));

//PE
priencoder pe(.pe_out(pe_out), .encoder_in(ssrms0_out[23:0]));

//xor
xor1bit xor1(.data_in1(regss_out), .data_in2(regst_out), .out(xor1_out));

xor1bit xor2(.data_in1(m16_out[0]), .data_in2(regsb_out), .out(xor2_out));

xor1bit xor3(.data_in1(regst_out), .data_in2(regss_out), .out(xor3_out));

//adder
add6 add(.A(regi_out), .B(regindex_out), .Sum(add_out), .Cout(Coutadd));

//RF
RF rf(.clk(clk), .data_in(m14_out), .data_outA(rf_aout), .data_outB(rf_bout), .WA(rf_wa), .RAA(rf_raa), .RAB(m15_out), .enable({rf_we,rf_reb,rf_rea}));

//FSM
FSM FSM( .clk(clk), .reset(reset), .start(start),
.mq47(srmq_out[47]), .mp47(srmp_out[47]), .r31(regr_out[31]), .msb(count_out[5]), .ms0_23(ssrms0_out[23]), .ms0_24(ssrms0_out[24]), .ms0_63(ssrms0_out[63]),
.comp1_g(comp1_out), .comp2_g(comp2_out), .stxor(xor3_out), .st(regst_out), .sumor(sumorrr_out), .mode(mode),
.mux5(mux5), .mux7(mux7), .mux10(mux10), .mux11(mux11), .mux15(mux15), .mux16(mux16), .mux18(mux18), .mux19(mux19), .mux22(mux22), .mux23(mux23),
.mux1(mux1), .mux4(mux4), .mux6(mux6), .mux12(mux12), .mux14(mux14), .mux20(mux20), .mux21(mux21),
.mux2(mux2), .mux3(mux3), .mux8(mux8), .mux9(mux9), .mux13(mux13), .mux17(mux17),
.rf_we(rf_we), .rf_rea(rf_rea), .rf_reb(rf_reb), .rf_wa(rf_wa), .rf_raa(rf_raa), .rf_rab(rf_rab),
.reg_sum(reg_sum), .reg_i(reg_i), .reg_currterm(reg_currterm), .reg_index(reg_index), .reg_reg(reg_reg), .reg_r(reg_r), .reg_numbit(reg_numbit), .reg_e(reg_e), .reg_acc(reg_acc),
.reg_sc(reg_sc), .reg_ec(reg_ec), .reg_mc(reg_mc), .reg_sb(reg_sb), .reg_eb(reg_eb), .reg_mb(reg_mb), .reg_sa(reg_sa), .reg_ea(reg_ea), .reg_ma(reg_ma),
.reg_sq(reg_sq), .reg_eq(reg_eq), .reg_ss(reg_ss), .reg_es(reg_es), .reg_ms(reg_ms), .reg_st(reg_st), .reg_et(reg_et), .reg_sp(reg_sp), .reg_ep(reg_ep),
.reg_es0(reg_es0), .reg_ss0(reg_ss0),
.sr_res(sr_res), .sr_mq(sr_mq), .sr_mt(sr_mt), .sr_mp(sr_mp), .ssr_ms0(ssr_ms0),
.alu1(alu1), .alu2(alu2), .counterii(counterii), .state(state_out));

endmodule
