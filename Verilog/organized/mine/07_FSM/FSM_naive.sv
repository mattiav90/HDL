
/*
this FSM is implemented to match the pattern 1011.
to make sure that it works.
this implementation has bianry states. 
Binary Encoding
Encoding: Minimal bits = ceil(log2(N_states))
Pros: Fewer flip-flops, lower area, often lower power.
Cons: More combinational decoding → longer critical path (bad for ultra-low-latency designs).
Decoding logic can add nanoseconds, which is bad for top-speed paths.
*/

module FSM_naive (
    input  logic clk,
    input  logic resetn,
    input  logic din,        // serial input bit
    output logic match
);

    parameter S0=0;
    parameter S1=1;
    parameter S2=2;
    parameter S3=3;
    parameter S4=4;

    logic [2:0] state, next_state;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= S0;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            S0: next_state = din ? S1 : S0;
            S1: next_state = din ? S1 : S2;
            S2: next_state = din ? S3 : S0;
            S3: next_state = din ? S4 : S2;
            S4: next_state = din ? S1 : S2;
        endcase
    end

assign match = (state==S4);
   

endmodule
