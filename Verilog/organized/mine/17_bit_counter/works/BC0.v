


//this is a naive and templated version of a bit counter. 
//this is not optimized but works for all cases. 


module BC0 #(
	parameter W=32
)(
input wire  [W-1:0] in,
output wire [$clog2(W)-1:0] count
);


integer i;
reg [$clog2(W)-1:0] c;

always @(*) begin
	c=0;
	for (i=0;i<W;i++) begin
		c= c + in[i];
	end
end


assign count = c; 


endmodule 
