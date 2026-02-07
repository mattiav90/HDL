

module model #(parameter BW=16)(
	input logic [BW-1:0] gray,
	output logic [BW-1:0] bin
);


always_comb begin
	for(int i=0; i<BW; i=i+1) begin
		bin[i] = ^ (gray>>i);
	end
end


endmodule
