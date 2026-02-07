

// LSB to MSB priority arbitrer.

module arb_ok #(parameter N=16)
(
	input  logic [N-1:0] req,
	output logic [N-1:0] grant
);

logic [$clog2(N):0] pos;
logic go;

always_comb begin
	pos=0;
	go=1;
	for(int i=0;i<N;i=i+1) begin
		pos = req[i] && go ? i : pos;
		go  = req[i] ? 0 : go;  
	end
	grant = 1 << pos;
end



endmodule
