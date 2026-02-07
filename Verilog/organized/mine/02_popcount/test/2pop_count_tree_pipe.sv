

module pop_count_tree_pipe #(
	parameter W=16
)(
input  logic clk,
input  logic [W-1:0] in,
output logic [$clog2(W):0] count
);

localparam STAGES=$clog2(W);
logic [$clog2(W):0] stage [0:STAGES][0:W-1];


genvar s,i;
generate

for(i=0;i<W;i++) begin
	always_ff @(posedge clk) begin
		stage[0][i] <= in[i];
	end
end

for (s=0;s<STAGES; s++) begin
	for(i=0; i<(W>>(s+1)); i++) begin
		always_ff @(posedge clk) begin
			stage[s+1][i] <= stage[s][2*i] + stage[s][2*i+1];
		end
	end
end

endgenerate



assign count = stage[STAGES][0];



endmodule
