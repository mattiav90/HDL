
//because the output is updated with always @ (*)
//this is mapped into combinatorial logic and there is no register involved.

module pe_8b 
(
	input wire [7:0]			in,
	output reg 					val,
	output reg [$clog2(7):0]	out
);


always @ (*) begin

	// valid is just the OR of the input. 
	val = | in;

	casex (in)
		8'b1xxxxxxx: out = 3'd7;
		8'b01xxxxxx: out = 3'd6;
		8'b001xxxxx: out = 3'd5;
		8'b0001xxxx: out = 3'd4;
		8'b00001xxx: out = 3'd3;
		8'b000001xx: out = 3'd2;
		8'b0000001x: out = 3'd1;
		8'b00000001: out = 3'd0;
		default    : out = 3'd0;
	endcase
	
end


endmodule
