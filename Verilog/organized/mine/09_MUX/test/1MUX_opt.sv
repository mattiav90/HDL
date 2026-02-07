




module MUX_opt #(
	parameter W=8,
	parameter IN=32
)(
	input  logic [W-1:0] in [0:IN-1],
	input  logic [$clog2(IN)-1:0] sel,
	output logic [W-1:0] out
);

parameter STAGES = $clog2(IN);
logic [W-1:0] stage [0:STAGES];

assign stage[0] = in;

genvar s;
generate 
	localparam SHIFT = 1<<s;
	for(s=0; s<STAGES; s++) begin
		//stage[s+1] = sel[s] ? { stage[s][W-1-SHIFT:0] , {SHIFT{1'b0}} } : stage[s];
		stage[s+1] = sel[s] ? stage[s] : stage[s];
	end
endgenerate


assign out = stage[STAGES];

endmodule
