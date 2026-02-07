

/*
for the carry select block, the delay is circa the addidion of BLOCKS bits, 
then a multiplexer to select the proper computed carry sum. 
trading extra area for lower latency. 
- if a latency of 1 cycle is ok, it is possible to pipeline after half the blocks to double fmax. 
- in placement of floor planning, placing adders in the same column of carry logic helps. 
- BLOCK dimension is tunable, smaller blocks = shorter carry delay but more area. 
*/

module carry_select #(
    parameter WIDTH = 32,
    parameter BLOCK = 8
)(
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    output logic [WIDTH-1:0] sum
);

localparam N = WIDTH / BLOCK;

wire [N:0] carry;
assign carry[0] = 1'b0;

genvar i;
generate
    for (i = 0; i < N; i = i + 1) begin : cs_block
        wire [BLOCK-1:0] sum0, sum1;
        wire c0, c1;

        assign {c0, sum0} = a[i*BLOCK +: BLOCK] + b[i*BLOCK +: BLOCK] + 1'b0;
        assign {c1, sum1} = a[i*BLOCK +: BLOCK] + b[i*BLOCK +: BLOCK] + 1'b1;

		assign carry[i+1] = carry[i]==0 ? c0 : c1;
		assign sum[i*BLOCK +: BLOCK] =  carry[i]==0 ? sum0 :sum1;

    end
endgenerate

endmodule
