module mux8_1_6(selector, data_in_000, data_in_001, data_in_010, data_in_011,
	data_in_100, data_in_101, data_in_110, data_in_111, data_out);

	input [2:0] selector;
   	input [5:0]  data_in_000, data_in_001, data_in_010, data_in_011, data_in_100, data_in_101, data_in_110, data_in_111;
	output [5:0] data_out;
   
	assign data_out = (selector == 3'b000) ? data_in_000 : 
			(selector == 3'b001) ? data_in_001 : 
			(selector == 3'b010) ? data_in_010 : 
			(selector == 3'b011) ? data_in_011 : 
			(selector == 3'b100) ? data_in_100 : 
			(selector == 3'b101) ? data_in_101 : 
			(selector == 3'b110) ? data_in_110 : 
			data_in_111;
   
endmodule
