

module naive_comparator #(parameter W=32)(
	input wire [W-1:0] a,
	input wire [W-1:0] b,
	output wire a_gt_b
);

assign a_gt_b = (a>b);


endmodule
