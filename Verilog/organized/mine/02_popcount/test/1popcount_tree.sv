

module pop_count_tree #(
	parameter W=16
)(
	input  logic [W-1:0] in,
	output logic [$clog2(W):0] count
);


localparam STAGES = $clog2(W);
logic [$clog2(W):0] stage [0:STAGES][W-1:0];



genvar s,i;
generate

for(i=0;i<W;i++) begin
	assign stage[0][i] = in[i];
end

for (s=0;s<STAGES;s++) begin
	for(i=0;i<(W>>(s+1));i++ ) begin
		assign stage[s+1][i] = stage[s][i*2] + stage[s][i*2+1];
	end
end

endgenerate

assign count = stage[STAGES][0];


endmodule
