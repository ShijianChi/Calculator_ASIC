module xor1bit(data_in1, data_in2, out);
input data_in1, data_in2;
output out;

assign out = (data_in1)^(data_in2);
endmodule
