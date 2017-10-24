module SSR(clk, S, data_in, data_out, ii); 
	input clk;
	input [2:0] S;
	input [63:0] data_in; 
	input [5:0] ii;
	output [63:0] data_out; 
	reg [63:0] tmp; 
 
  	always @(posedge clk) 
    	begin 
		case(S)
		3'b001: tmp <= data_in; //load
		3'b010: tmp <= tmp << 1;  //Lshift
		3'b011: tmp <= tmp >> 1;  //Rshift
		3'b100: tmp[ii] <= 0;
		3'b101: tmp[ii] <= 1;
		default: tmp <= tmp;
		endcase
	end 
	assign data_out = tmp ;
endmodule 