
//detect 101

// in this other implementation there is only combinatorial logic
// to set the output to 1. in this way I dont have to wait for one
// cycle to get the result of the match comparison in the output. 

// on the other hand, having straight combinatorial logic in the output
// might create clitches. 

module pattern_fsm4 (
input wire clk,
input wire rstn,
input wire data_in,
output wire match	
);


localparam S0 = 3'b001;
localparam S1 = 3'b010;
localparam S2 = 3'b100;

reg [2:0] state;

// again in theory here I dont need the next state.
// I can just compute state direcly and assign the next state to state.

always @ (posedge clk or negedge rstn) begin
	if(!rstn) begin
		state<=S0;
	end else begin
		case (state)
		S0: state = data_in ? S1:S0;	//notice that I use the stright wire to compare
		S1: state = data_in ? S1:S2;	//very efficient selection
		S2: state = data_in ? S1:S0;
		default state = S0;
		endcase
	end
end

// set the output with combinatorial logic.
// use the bits of state to chech the state directly.
assign match = state[2] & data_in;


endmodule
