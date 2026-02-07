/*
this type of additoin create a serial dependency. 
(((((((in0 + in1) + in2) + in3) + in4) + in5) + in6) + in7)

The critical path is N−1 adders long → terrible for timing.
On an FPGA, this will never meet high fmax if N is large.

Naive chain:
Latency: 1 cycle
Critical path: N−1 adders
*/


module naive #(
    parameter WIDTH = 32,
    parameter N     = 8
) (
    input  logic [WIDTH-1:0] in [N],
    output logic [WIDTH-1+$clog2(IN):0] sum
);
    integer i;
    logic [WIDTH-1+$clog2(IN):0] acc;

    always_comb begin
        acc = '0;
        for (i = 0; i < N; i++) begin
            acc = acc + in[i];
        end
        sum = acc;
    end
endmodule
