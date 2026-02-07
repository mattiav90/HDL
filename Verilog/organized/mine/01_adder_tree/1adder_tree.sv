/*
Balanced Adder Tree (Optimized)
additions are arranged in a binary tree. 

each stage has half the initial number of input dimension (logaritmic tree). 

Stage 1: Add pairs in parallel → N/2 results
Stage 2: Add those results → N/4 results
Repeat until 1 result remains.

this is implementation is not pipelined, so the tree itself is combinatorial logic. 
that means that the cirtical path lies in the bepth of the tree. 
Critical path length = log₂(N) adders instead of N−1 (naive implementation).

Balanced tree:
Latency: 1 cycle. only combinatorial logic. 
Critical path: log₂(N) adders
*/



module adder_tree #(
	parameter W=32,
	parameter N=8
)(
	input  logic [W-1:0] in [N-1:0],
	output logic [W-1+$clog2(IN):0] sum
);


localparam STAGES = $clog2(N);

logic [W-1:0] stage [0:STAGES][N-1:0];

genvar i,s;
generate 

	for(i=0;i<N;i++) begin
		assign stage[0][i] = in[i];
	end

	for(s=0; s<STAGES; s++ ) begin
		for(i=0; i< (N>>(s+1)) ; i++  ) begin
			assign stage[s+1][i] = stage[s][2*i] + stage[s][2*i+1];
		end
	end
endgenerate

assign sum = stage[STAGES][0];


endmodule
