

module bit_counter_sim #(parameter W=32)(
	input wire [W-1:0] 		in,
	output reg [$clog2(W):0] count
);

integer i;
reg [$clog2(W):0] c;

always @(*) begin
	c=0;
	for (i=0; i<W; i=i+1) begin
		c=c+in[i];
	end
	count=c;
end

endmodule
