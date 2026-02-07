

module model #(parameter BW=32)
(
	input logic [BW-1:0] din,
	output logic dout
);

logic same;

always_comb begin
	same=1;
	for(int i=0; i<(BW/2)+1; i=i+1) begin
		same = din[i]==din[BW-1-i] ? same : 0;
	end
end

assign dout = same;


endmodule
