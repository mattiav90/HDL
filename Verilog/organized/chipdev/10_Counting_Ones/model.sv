
module model #(parameter BW=16)(
	input logic [BW-1:0] din,
	output logic [$clog2(BW):0] dout
);

logic [$clog2(BW):0] temp;

always_comb begin
	temp=0;
	for(int i=0; i< BW; i=i+1) begin
		temp=temp+din[i];
	end
end

assign dout=temp;


endmodule
