module mux4_1(selector, data_in_00, data_in_01, data_in_10, data_in_11, data_out);
   input [1:0]    selector;
   input [31:0]  data_in_00;
   input [31:0]  data_in_01;
   input [31:0]  data_in_10;
   input [31:0]  data_in_11;
   output [31:0] data_out;
   
   assign data_out = (selector == 2'b00) ? data_in_00 : 
                     (selector == 2'b01) ? data_in_01 : 
                     (selector == 2'b10) ? data_in_10 : 
                     data_in_11;
   
endmodule
