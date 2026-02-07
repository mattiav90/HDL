/*

this is a naive implementation of a multiplexer. 
can get inefficient of the fan in is too big.

*/


module mux_naive #(
    parameter WIDTH = 64,
    parameter SEL_W = 4  // selects among 2^SEL_W inputs
)(
    input  logic [WIDTH-1:0] inputs [0:(1<<SEL_W)-1],
    input  logic [SEL_W-1:0] sel,
    output logic [WIDTH-1:0] out
);


    assign out = inputs[sel];

    
endmodule
