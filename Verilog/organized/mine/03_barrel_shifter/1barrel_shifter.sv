
/*
BARREL SHIFTER.
Shift in stages. Each stage either shifts by 2^i or not, controlled by a single bit of 
the shift amount. This is the canonical low-latency design.

We have log2(WIDTH) stages.
At each stage i, if bit shift_amount[i] is set, shift left by 2^i.
Otherwise, pass the data through unchanged.
Each stage is a multiplexer selecting between shifted and unshifted data.
*/

module barrel_shifter #(
	parameter W=32
)(
	input  logic [W-1:0] in,
	input  logic [$clog2(W)-1:0] shift,
	output logic [W-1:0] out
);

localparam STAGES = $clog2(W);
logic [W-1:0] stage [0:STAGES];

assign stage[0] = in;

genvar s;
generate
	for(s=0;s<STAGES;s++) begin
		localparam SHIFT=1<<s;
		assign stage[s+1] = shift[s] ? {stage[s][W-SHIFT-1:0], {SHIFT{1'b0}} } : stage[s];
	end
endgenerate

assign out = stage[STAGES];

endmodule
