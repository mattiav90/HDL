

module arb #(parameter N=8)(
	input  logic [N-1:0] req,
	output logic [N-1:0] grant
);


logic go;
logic [$clog2(N):0] temp;


always_comb begin
	go=1;
	temp=0;
	for (int i=N-1;i>=0;i=i-1) begin
		temp = req[i] && go ? i : temp;
		go   = req[i]       ? 0 : go; 
	end
end

assign grant = !go ? 1<<temp : 0;



endmodule
