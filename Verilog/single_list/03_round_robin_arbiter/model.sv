
module model #(parameter N=8)(
	input logic clk,
	input logic reset,
	input logic [N-1:0] din,
	output logic [N-1:0] grant
);

logic [N-1:0] next, grant_next;
logic found;
logic [$clog2(N)-1:0] state;


always_ff @(posedge clk) begin
	if(reset) begin
		state<=0;
	end else begin
		state<=next;
	end
end


always_comb begin
	int index;

	found=0;
	grant='0;

	for (int i=0; i<N; i++) begin
		index= (state + i)%N;
		
		if(!found && din[index]) begin
			grant[index]=1;
			found=1;
			next=(index+1)%N;
		end
	end
end


endmodule
