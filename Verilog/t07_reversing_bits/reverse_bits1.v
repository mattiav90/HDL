

module reverse_bits #(parameter W=8)(
	input wire [W-1:0] din,
	output reg [W-1:0] dout
);

integer i;

always @ (*) begin

 for (i=0; i<W; i=i+1) begin
	dout[i]=din[(W-1)-i];
 end

end



endmodule
