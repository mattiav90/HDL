
//beacuse the output is updated with always @ (*)
//the output is updated with combinatorial logic. there is no register in here

// 4 input priority encoder

module pe_4b (
	input wire [3:0] 	in,
	output reg 			val,
	output reg [1:0] 	out
);

always @ (*) begin

	val = |in;
	casex(in)
		4'b1xxx: out = 3;
		4'b01xx: out = 2;
		4'b001x: out = 1;
		4'b0001: out = 0;
		default: out = 0;	
	endcase

end

endmodule
