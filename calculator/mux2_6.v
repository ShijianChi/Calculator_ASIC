module mux2_1_6(selector, data_in_0, data_in_1, data_out);
   input     selector;
   input [5:0]  data_in_0;
   input [5:0]  data_in_1;
   output [5:0] data_out;
   
   assign data_out = (selector == 1'b0) ? data_in_0 :  
                     data_in_1;
   
endmodule
