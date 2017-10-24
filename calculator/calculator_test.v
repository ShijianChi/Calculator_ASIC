
`timescale 1ns/1ns
`define clk_cycle 50
`include "./calculator.nl.v"
//`include "./calculator.v"

module calculator_test;
reg clk,start,reset;
reg[2:0] mode;
reg[31:0] calculator_input, n_input;

wire[31:0] regacc_out;
wire[8:0] state_out;
wire Coutadd, Coutone, Couttwo;

wire regss0_out;
wire[31:0] m14_out, alutwo_out,  m17_out, m18_out, regec_out, regeb_out, rf_aout, regcurrterm_out, regsum_out,
	srmt_out, regms_out, reges_out, reget_out, reges0_out, aluone_out, regreg_out, rege_out;
wire[63:0] srmq_out, ssrms0_out;
wire[5:0] regi_out;
always #`clk_cycle clk = ~clk;
initial
	begin
	clk=0; start=0; reset=1; mode=3'b000; calculator_input=32'b0; n_input=32'b0;
	#100 reset=0;
	#100 start=1; mode =3'b101; calculator_input=32'h3e4ccccd; n_input=32'd5;
	#200 start=0;
	#50000 $stop;
	end
calculator calculator(clk,start,reset,mode, calculator_input, n_input, regacc_out, state_out, Coutadd, Coutone, Couttwo,
 m14_out, alutwo_out, m17_out, m18_out, srmq_out, regec_out, regeb_out, rf_aout, regi_out, regcurrterm_out, regsum_out,
srmt_out, regms_out, reges_out, reget_out, regss0_out, reges0_out, ssrms0_out, aluone_out, regreg_out, rege_out);

endmodule
