
module arb #(parameter N=8)(
	input  logic clk,
	input  logic rst,
	input  logic [N-1:0] req,
	output logic [N-1:0] grant	
);


logic [$clog2(N):0] ptr, newptr;

always_ff @(posedge clk) begin
	if(rst) begin
		ptr<=0;
	end else begin
		ptr<=newptr;
	end
end



always_comb begin
int idx, k;
logic found;
grant='0;
newptr=ptr;
found=0;
for (k=0; k<N; k=k+1) begin
	idx= ptr+k;
	if (idx>=N) idx=idx-N;	//wrap
	if(!found && req[idx]) begin
		grant[idx]=1;
		found=1;
		newptr = idx==N-1 ? 0 : idx+1;	
	end
end




end


endmodule
