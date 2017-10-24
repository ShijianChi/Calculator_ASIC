module add6(A, B, Sum, Cout);
   
	input [5:0]  A,B;
	output [5:0] Sum;
	output Cout;
   
	assign {Cout, Sum}= A + B;
   
endmodule
