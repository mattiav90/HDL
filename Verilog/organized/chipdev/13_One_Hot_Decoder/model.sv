

module model #(parameter BW=16)(
	input [BW-1:0] din,
	output onehot
);

logic [1:0] temp;

always_comb begin
	temp=0;
	for(int i=0; i<BW; i=i+1) begin
		temp=temp+din[i];
	end
end

assign onehot = temp==1;


endmodule
