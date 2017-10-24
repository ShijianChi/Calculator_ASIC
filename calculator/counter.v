`define load 3'b100
`define inc1 3'b010
`define dec1 3'b011

module counter(clk, data_in, data_out, control);
input [5:0] data_in;
input clk;
output [5:0] data_out;
input [2:0] control;
reg [5:0] data_out;

always @ (posedge clk)
begin
	case (control)
	`load : data_out <= data_in;
	`inc1 : data_out <= data_out+1;
	`dec1 : data_out <= data_out-1;
	default: data_out <= data_out;
	endcase
end
endmodule

