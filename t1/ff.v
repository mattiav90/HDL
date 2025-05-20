module ff(
	input wire clk,
	input wire d,
	input wire rst,
	output reg q
);

always @ (posedge clk) begin
	if(~rst) begin
		q<=0;
	end else begin
		q<=d;
	end
end

endmodule
