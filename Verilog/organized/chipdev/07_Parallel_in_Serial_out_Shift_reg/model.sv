module model #(parameter BW=16)
(
	input  logic clk,
	input  logic resetn,
	input  logic din_en,
	input  logic [BW-1:0] din,
	output logic dout 
);

logic [BW-1:0] temp;

always_ff @(posedge clk) begin
	if (~resetn) begin
		temp<=0;
	end else if (din_en) begin
		temp<=din;
	end else if (~din_en) begin
		temp<=temp>>1;
	end
end

assign dout=temp[0];

endmodule
