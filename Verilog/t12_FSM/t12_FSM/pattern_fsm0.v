
//recognize pattern 010 with a state machine

module pattern_fsm0 (
	input wire clk,
	input wire rstn,
	input wire data_in,
	output reg match
);


localparam S0 = 2'd0;
localparam S1 = 2'd1;
localparam S2 = 2'd2;

reg [1:0] state, nxt_state;


//state register
always @ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		state<=0;
	end
		state<=nxt_state;
end


//combinatorial logic to pick the next state
always @ (*) begin
	case(state) 
		S0: nxt_state = (data_in==0) ? S1 : S0;
		S1: nxt_state = (data_in==1) ? S2 : S1;
		S2: nxt_state = (data_in==0) ? S1 : S0;
		default nxt_state=S0;
	endcase
end


//match register
always @ (posedge clk or negedge rstn) begin
	if(!rstn) begin
		match<=0;
	end else begin
		match<= (state==S2) & (data_in==0);
	end
end




endmodule
