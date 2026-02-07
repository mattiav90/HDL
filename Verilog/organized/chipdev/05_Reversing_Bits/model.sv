
module model #(parameter BW=32)
(
input logic [BW-1:0] din,
output logic [BW-1:0] dout
);

logic [BW-1:0] temp;

always_comb begin
	for (int i=0; i<BW; i=i+1) begin
		dout[i] = din[BW-1-i];
	end
end

endmodule
