module Bshifterright(data_in, data_out, bits);
	input [31:0] data_in;
	input [31:0] bits;
	output [31:0] data_out;
assign data_out = data_in >> bits;
endmodule