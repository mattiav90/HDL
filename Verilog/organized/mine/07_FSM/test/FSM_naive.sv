
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
	input  logic din,
	output logic match
);

localparam S0=0;
localparam S1=1;
localparam S2=2;
localparam S3=3;
localparam S4=4;

logic [2:0] state, next;


always_ff @(posedge clk) begin
	if (!resetn) begin
		state<=S0;
	end else begin
		state<=next;
	end
end


always_comb begin
	case (state)
            S0: next = din ? S1 : S0;
            S1: next = din ? S1 : S2;
            S2: next = din ? S3 : S0;
            S3: next = din ? S4 : S2;
            S4: next = din ? S1 : S2;
	endcase
end


assign match = state== S4;






endmodule
