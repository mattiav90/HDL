

module trailing #(parameter BW=16)(
	input logic [BW-1:0] din,
	output logic [$clog2(BW)-1:0] dout
);

logic go;
logic  [$clog2(BW)-1:0] temp;

always_comb begin
	temp=0;
	go=1;
	for(int i=0;i<BW;i=i+1) begin
		temp= din[i]==0 && go ? temp+1 : temp;
		go = din[i]==1 ? 0 : go;
	end
end

assign dout=temp;


endmodule
