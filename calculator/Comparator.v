module comparator(data_in1, data_in2, G);
	input [31:0] data_in1, data_in2;
	output G;
	reg G;

	always@(data_in1 or data_in2)
		begin
			if (data_in1 > data_in2)
			G=1;
			else G=0;
		end
endmodule
