

module pe_4b (
	input wire [3:0] in,
	output reg [$clog2(4)-1:0] out,
	output wire val
);


always @ (*) begin

	casex (in)
	4'b0001:	out=0;
	4'b001x:	out=1;
	4'b01xx:	out=2;
	4'b1xxx:	out=3;
	default:	out=0;
	endcase

end

assign 	val = |in;

endmodule
