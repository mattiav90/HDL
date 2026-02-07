


module barrel_shifter #(
	parameter W=32
)(
	input logic [W-1:0] in,
	input logic [$clog2(W)-1:0] shift,
	output logic [W-1:0] out
);

localparam STAGES=$clog2(W);
logic [W-1:0] stage [0:STAGES];

assign stage[0]=in;

genvar s;
generate 
	for(s=0;s<STAGES;s++) begin
	localparam SHIFT= 1<<s;

	assign stage[s+1] = shift[s] ? {stage[s][W-SHIFT-1:0],{SHIFT{1'b0}}} : stage[s];
	end
endgenerate


assign out = stage[STAGES];



endmodule
