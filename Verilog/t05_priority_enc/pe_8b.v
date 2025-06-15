


module pe_8b (
	input wire [7:0] in,
	output reg [$clog2(8)-1:0] out,
	output wire val
);

always @ (*) begin
	casex (in)
	8'b00000001:	out=0;
	8'b0000001x:	out=1;
	8'b000001xx:	out=2;
	8'b00001xxx:	out=3;
	8'b0001xxxx:	out=4;
	8'b001xxxxx:	out=5;
	8'b01xxxxxx:	out=6;
	8'b1xxxxxxx:	out=7;
	default:		out=0;
	endcase

end

assign val =|in;


endmodule 
