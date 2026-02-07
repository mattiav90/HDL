/*
What does "derive equations by inspection" mean?
One-hot state machine encoding guarantees that exactly one state bit is 
1. This means that it is possible to determine whether the state machine
 is in a particular state by examining only one state bit, not all state
  bits. This leads to simple logic equations for the state
 transitions by examining the incoming edges for each state in the 
 state transition diagram.

For example, in the above state machine, how can the state machine can 
reach state A? It must use one of the two incoming edges: "Currently in
 state A and in=0" or "Currently in state C and in = 0". Due to the 
 one-hot encoding, the logic equation to test for "currently in state 
 A" is simply the state bit for state A. This leads to the final logic
  equation for the next state of state
   bit A: next_state[0] = state[0]&(~in) | state[2]&(~in). 
   The one-hot encoding guarantees that at most one clause
    (product term) will be "active" at a time, so the clauses 
    can just be ORed together.

When an exercise asks for state transition equations "by inspection"
, use this particular method.

*/



module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = state[0]&(~in) | state[2]&(~in);
    assign next_state[B] = ...;
    assign next_state[C] = ...;
    assign next_state[D] = ...;

    // Output logic: 
    assign out = state[3];

endmodule
