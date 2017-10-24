module RF(clk, data_in, data_outA, data_outB, WA, RAA, RAB, enable);

input clk;
input[31:0] data_in;
input[2:0] enable; // WE, REB, REA
input [5:0] WA, RAA, RAB;
output [31:0] data_outA, data_outB;
reg [31:0] data_outA, data_outB;

//reg [5:0] r1, r2;
//define the memory block
reg [31:0] Mem[63:0];

//declare the values that are read only
/*initial
begin
	Mem[0] =32'b0;
	Mem[1] =32'hffffffff;
end*/
always @ (enable)
	begin
	case (enable)
	3'b001: data_outA <= Mem[RAA];
	3'b101: data_outA <= Mem[RAA];
	3'b010: data_outB <= Mem[RAB];
	3'b110: data_outB <= Mem[RAB];
	3'b011: begin data_outA <= Mem[RAA]; data_outB <= Mem[RAB]; end
	3'b111: begin data_outA <= Mem[RAA]; data_outB <= Mem[RAB]; end
	default: begin data_outA <= 'bx; data_outB <= 'bx; end
	endcase
	end

always @ (posedge clk)
	begin
	Mem[0]<=32'h3f800000;
	Mem[1]<=32'h3f800000;
	Mem[2]<=32'h3f000000;
	Mem[3]<=32'h3e2aaaab;
	Mem[4]<=32'h3d2aaaab;
	Mem[5]<=32'h3c088889;
	Mem[6]<=32'h3ab60b61;
	Mem[7]<=32'h39500d01;
	Mem[8]<=32'h37d00d01;
	Mem[9]<=32'h3638efed;
	Mem[10]<=32'h3493f27e;
	Mem[11]<=32'h32d7322b;
	Mem[12]<=32'h310f76c8;
	Mem[13]<=32'h2f309231;
	Mem[14]<=32'h2d49cba5;
	Mem[15]<=32'h2b573f9f;
	Mem[16]<=32'h29573f9f;
	Mem[17]<=32'h274a963c;
	Mem[18]<=32'h253413c3;
	Mem[19]<=32'h2317a4da;
	Mem[20]<=32'h20f2a15d;
	Mem[21]<=32'h1eb8dc78;
	Mem[22]<=32'h1c8671cb;
	Mem[23]<=32'h1a3b0da1;
	Mem[24]<=32'h17f96781;
	Mem[25]<=32'h159f9e67;
	Mem[35]<=32'h40135d8e;

	case(enable)
	/*3'b001: begin 
		data_outA <= Mem[RAA]; data_outB <= 'bx;
		end
	3'b010: begin 
		data_outA <= 'bx; data_outB <= Mem[RAB];
		end
	3'b011: begin 
		data_outA <= Mem[RAA]; data_outB <= Mem[RAB];
		end*/
	3'b100: begin 
		Mem[WA] <= data_in;
		end
	3'b101: begin 
		Mem[WA] <= data_in; 
		end
	3'b110: begin 
		Mem[WA] <= data_in;
		end
	3'b111: begin 
		Mem[WA] <= data_in;
		end

	endcase

	end
//assign data_outA = Mem[r1];
//assign data_outB = Mem[r2];
		
endmodule
