
/*
One-Hot Encoding
Encoding: 1 FF per state, only one bit is 1 at a time.
Pros: Very fast next-state logic, minimal decoding.
Cons: More flip-flops, more area.
Faster transitions, worth the extra FFs when the number of states is small (<20–30).

each state has a state directly encoded in one FF. very easy to check the state and set the 
output flag. also the state transition does not have MUX, it is only combinatorial logic. 

*/


module FSM_opt (
    input  logic clk,
    input  logic resetn,
    input  logic din,
    output logic match
);

    // State bit encoding: one-hot
    localparam S0=0, S1=1, S2=2, S3=3, S4=4;

    logic [4:0] state, nstate;

    // State registers
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state<=5'b00001;
        end else begin
            state<=nstate;
        end
    end

    // Pure combinational logic for next states
    assign nstate[S0] = (state[S0] & ~din) | (state[S2] & ~din);
    assign nstate[S1] = (state[S0] & din) | (state[S1] & din) | (state[S4] & din);
    assign nstate[S2] = (state[S1] & ~din) | (state[S3] & ~din) | (state[S4] & ~din);
    assign nstate[S3] = (state[S2] & din);
    assign nstate[S4] = (state[S3] & din);

    // Match = in S4
    assign match = state[S4];

endmodule
