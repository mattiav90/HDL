

/*
naive popcount implementation.
this implementation synthesize to a long carry chain. very poor timing. 
the latency is only one cycle, but the fmax will be limited by the long 
critical path.
*/

module naive #(
	parameter W=64
)(
input logic [W-1:0] in,
output logic [$clog2(W+1)-1:0] count
);

logic  [$clog2(W+1)-1:0] temp;


integer i; 
always_comb begin
	temp=0;
for (i=0;i<W;i++) begin
	temp= temp+in[i];
end
end

assign count = temp;
endmodule
