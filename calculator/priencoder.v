module priencoder (pe_out , encoder_in );
 
	output [5:0] pe_out ;
	//input  enable ; 
	input [23:0] encoder_in ; 
	wire [5:0] pe_out ;
	
	assign  pe_out  = ((encoder_in[23]) ? 0 : 
		(encoder_in[22]) ? 1 : 
		(encoder_in[21]) ? 2 : 
		(encoder_in[20]) ? 3 : 
		(encoder_in[19]) ? 4 : 
		(encoder_in[18]) ? 5 : 
		(encoder_in[17]) ? 6 : 
		(encoder_in[16]) ? 7 : 
		(encoder_in[15]) ? 8 : 
		(encoder_in[14]) ? 9 : 
		(encoder_in[13]) ? 10 : 
		(encoder_in[12]) ? 11 : 
		(encoder_in[11]) ? 12 : 
		(encoder_in[10]) ? 13 : 
		(encoder_in[9]) ? 14 : 
		(encoder_in[8]) ? 15 : 
		(encoder_in[7]) ? 16 : 
		(encoder_in[6]) ? 17 : 
		(encoder_in[5]) ? 18 : 
		(encoder_in[4]) ? 19 : 
		(encoder_in[3]) ? 20 : 
		(encoder_in[2]) ? 21 : 
		(encoder_in[1]) ? 22 : 23);

endmodule 
