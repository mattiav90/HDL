
module arb #(parameter N=8)(
	input logic  clk,
	input logic  rst, 
	input logic  [N-1:0] req,
	output logic [N-1:0] grant
);


localparam PTR_W = $clog2(N);

logic [PTR_W-1:0] pointer, next;
logic found;

always_ff @(posedge clk) begin
	if(rst) 
		pointer<='0;
	else 
		pointer<=next;
end



always_comb begin
	grant='0;
	found=0;
	next=pointer;	
	
	for (int i=0; i<N; i++) begin
		int index;
		index = (pointer +i) % N;

		if(req[index] && !found) begin
			found=1;
			grant[index]=1'b1;
			next = (index+1) % N;
		end	
	end
end



endmodule
