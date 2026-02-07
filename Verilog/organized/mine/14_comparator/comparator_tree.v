

module comparator_tree #(parameter W=32)(
 input wire [W-1:0] a,
 input wire [W-1:0] b,
 output wire a_gt_b	
);


localparam HALF=W/2;
wire up_gt,lw_gt;
wire top_eq;

fast_comparator #(HALF) upper (a[W-1:HALF],b[W-1:HALF],up_gt);
fast_comparator #(HALF) lower (a[HALF-1:0],b[HALF-1:0],lw_gt);



assign top_eq = (a[W-1:HALF]==b[W-1:HALF]);

assign a_gt_b = up_gt  | (lw_gt & top_eq);


endmodule
