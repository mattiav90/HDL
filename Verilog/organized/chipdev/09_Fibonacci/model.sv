
module model #(parameter BW=16)(
	input  logic clk,
	input  logic resetn,
	output [BW-1:0] dout
);

logic [BW-1:0] f0,f1;

always_ff @(posedge clk) begin
	if(~resetn) begin
		f0<=1;
		f1<=1;
	end else begin
		f0<=f1;
		f1<=f0+f1;
	end
end

assign dout = f0;


endmodule
