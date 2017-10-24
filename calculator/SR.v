module SR(clk, S, data_in, data_out); 
	input clk;
	input [1:0] S;
	input [31:0] data_in; 
	output [31:0] data_out; 
	reg [31:0] tmp; 
 
  	always @(posedge clk) 
    	begin 
		case(S)
		2'b01: tmp <= data_in;
		2'b10: tmp <= tmp<<1;
		2'b11: tmp <= tmp>>1;
		default: tmp <= tmp;
		endcase
	end 
	assign data_out = tmp ;
endmodule 
