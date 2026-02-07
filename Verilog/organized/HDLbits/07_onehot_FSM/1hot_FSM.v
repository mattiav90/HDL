module top_module(
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output out1,
    output out2
);
    
    parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, S9=9;

    always @(*) begin
        next_state = 10'b0; // Important: Clear next_state first

        next_state[S0] = ~in & (state[S0] | state[S1] | state[S2] | state[S3] | state[S4] | state[S8] | state[S9] | state[S7]);
        next_state[S1] = (state[S0] & in) | (state[S8] & in) | (state[S9] & in);
        next_state[S2] = state[S1] & in;
        next_state[S3] = state[S2] & in;
        next_state[S4] = state[S3] & in;
        next_state[S5] = state[S4] & in;
        next_state[S6] = state[S5] & in;
        next_state[S7] = state[S6] & in | state[S7] & in;
        next_state[S8] = state[S5] & ~in;
        next_state[S9] = state[S6] & ~in;
    end

    assign out1 =  state[S8]| state[S9];
    assign out2 =  state[S7]| state[S9];

endmodule




/*

one hot FSM are more efficient. 
write them in this way shown here. 
only combinatorial logic take care to perform the stat transition
and also each state can be checked with just a wire directly connected 
to a register. 
very fast ! 

*/
