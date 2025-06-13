
//detect 101

// in this other implementation there is only combinatorial logic
// to set the output to 1. in this way I dont have to wait for one
// cycle to get the result of the match comparison in the output. 

// on the other hand, having straight combinatorial logic in the output
// might create clitches. 

// to avoid having stright combinatorial logic in the output, I can 
// assign the combinatorial logic to a register.
// and then assign the output value of the register to the output wire.
// in this way, it should be more stable to glitches. 

module pattern_fsm3 (
input wire clk,
input wire rstn,
input wire data_in,
output wire match	
);


localparam S0 = 3'b001;
localparam S1 = 3'b010;
localparam S2 = 3'b100;

reg [2:0] state, next_state;
reg match_r;


always @ (posedge clk or negedge rstn) begin
if(!rstn) begin
	state<=S0;
end else begin
	state<= next_state;
end
end

always @ (*) begin
case (state)
S0: next_state = data_in ? S1:S0;	//notice that I use the stright wire to compare
S1: next_state = data_in ? S1:S2;	//very efficient selection
S2: next_state = data_in ? S1:S0;
default next_state = S0;
endcase
end

// compute the match with combinatorial logic and assign it to a reg.

always @(*) begin
	match_r <= state[2] & data_in;
end

//connect the reg to the output wire. 
assign match = match_r;



endmodule
