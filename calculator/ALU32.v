`define nega 3'd0
`define band 3'd1
`define bor 3'd3
`define dec 3'd4
`define add 3'd5
`define sub 3'd6
`define inc 3'd7

module ALU32(data_in1, data_in2, alu_out, opcode, Cout);
	output [31:0] alu_out;
	output Cout;
	reg [31:0] alu_out;
	reg Cout;
	input [31:0] data_in1, data_in2;
	input [2:0] opcode;

always @(opcode or data_in1 or data_in2)

begin
	case(opcode)
	`nega: alu_out = ~(data_in1);	//complement
	`band: alu_out = (data_in1 & data_in2);	//and
	`bor: alu_out = (data_in1 | data_in2);	//or
	`dec: {Cout,alu_out} = (data_in1 - 1);	//decrement
	`add: {Cout,alu_out} = data_in1 + data_in2;	//add
	`sub: {Cout,alu_out} = data_in1 + (~data_in2) +1;	//sub
	`inc: {Cout,alu_out} = data_in1 + 1;	//increment
	default: alu_out = data_in1;
	endcase
end
endmodule 
