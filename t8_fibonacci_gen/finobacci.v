
// this is interesting because it can be implemented with a shifter.
// just a chain of flip flops that update in the right way. 


module fibonacci #(parameter W=32)
(
	input  wire  clk,
	input  wire  [W-1:0] din,
	input  wire  resetn,
	output wire  [W-1:0] dout
);


reg [W-1:0] a,b,c;


always @ (posedge clk) begin
	if (!resetn) begin
		a<=2;
		b<=1;
		c<=1;
	end else begin
		c<=b;
		b<=a;
		a<=a+b;
	end
end


assign dout = c;


endmodule
