
module rr_arb #(parameter N=8)(
	input logic  clk,
	input logic  reset,
	input logic  [N-1:0] req,
	output logic [N-1:0] grant
);


localparam BW = $clog2(N);

logic [BW-1:0] pointer, next;
logic found;

always_ff @(posedge clk) begin
	if(reset)
		pointer <= '0;
	else
		pointer <= next;
end


always_comb begin
	int index;

	found=0;
	grant='0;

	for(int i=0; i<N; i++) begin
			index= (pointer+i) % N;

			if(!found && req[index]) begin
				found=1;
				grant[index]=1;
				next= (index+1) % N;
			end
	end
	
end

endmodule
