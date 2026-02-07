
module model #(parameter BW=16)(
	input logic clk,
	input logic resetn,
	input logic din,
	output logic [BW-1:0] dout
);

logic [BW-1:0] temp;

always_ff @(posedge clk) begin
	if(~resetn) begin
		temp<=0;
	end else begin
		temp<= (temp<<1) + din;
	end
end


assign dout= temp;


endmodule
