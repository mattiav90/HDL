
module FSM_opt (
	input  logic clk,
	input  logic resetn,
	input  logic din,
	output logic match
);


logic [4:0] state, nstate;
parameter S0=0, S1=1, S2=2, S3=3, S4=4;

always_ff @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state<=5'd1;
	end else begin
		state<=nstate;
	end
end

assign nstate[S0] = state[S0]&~din | state[S2]&~din;
assign nstate[S1] = din & (state[S0] | state[S1] | state[S4]);
assign nstate[S2] = ~din & (state[S1] | state[S3] | state[S4]);
assign nstate[S3] = din & state[S2];
assign nstate[S4] = din & state[S3];


assign match = state[S4];

endmodule
