
module arb_ok #(parameter N=16)(
	input  logic [N-1:0] req,
	output logic [N-1:0] grant
);


logic [$clog2(N):0] pos;
logic go;

always_comb begin
	pos=0;
	go=1;
	for(int i=N-1; i>=0; i--) begin
		pos = req[i] && go ? i : pos;
		go = req[i] ? 0 : go;
	end
	grant = 1 << pos;
end


endmodule
