module mult32(A, B, Product);
   
   input [31:0]  A,B;
   output [63:0] Product;
   
   assign Product = A * B;
   
endmodule
