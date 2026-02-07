

module adder_tree #(parameter IN=16,
					parameter W=8
)(
	input logic [W-1:0] in [0:IN-1],
	output logic [W-1+$clog2(IN):0] sum
);


localparam STAGES = $clog2(IN);
localparam WADD = W+$clog2(IN);
logic [WADD-1:0] stage [0:STAGES][0:IN-1];


genvar s,i;
generate
	for(i=0;i<IN;i++) begin
		assign stage[0][i] = in[i];
	end

	for (s=0;s<STAGES;s++) begin
		for (i=0;i<(IN>>(s+1));i++) begin
			assign stage[s+1][i] = stage[s][i*2] + stage[s][i*2+1];
		end
	end
endgenerate

assign sum = stage[STAGES][0];

endmodule
