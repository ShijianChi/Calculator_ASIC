module reg6(clk, load, data_in, data_out);
	input clk;
	input load;
	input[5:0] data_in;
	output[5:0] data_out;
   
	reg[5:0] data_out_buffer;
   
	always
	begin
	@(posedge clk);
      
	if (load == 1'b1)
		data_out_buffer <= data_in;
		else
		data_out_buffer <= data_out_buffer;
	end
   
	assign data_out = data_out_buffer;
   
endmodule
