
module shift_reg_sim 
#(parameter W=8, parameter D=8)
(
	input wire clk,
	input wire rst,
	input wire [W-1:0] din,
	output reg [W-1:0] dout
);


integer i;

reg [W-1:0] regn[0:D-2];


always @(posedge clk or negedge rst) begin

if(!rst) begin
	for (i=0;i<D-1;i=i+1) begin
		regn[i]<=0;
	end
	dout<=0;
end else begin
	regn[0]<=din;
	for (i=0;i<D-2;i=i+1) begin
		regn[i+1]<=regn[i];
	end
	dout<=regn[D-2];
end
end 


endmodule
