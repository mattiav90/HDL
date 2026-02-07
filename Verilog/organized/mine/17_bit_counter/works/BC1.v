module popcount8 (
    input  wire [7:0] in,
    output wire [3:0] count
);

assign count = in[0] + in[1] + in[2] + in[3] +
               in[4] + in[5] + in[6] + in[7];

endmodule



module bit_counter_chunks (
    input  wire [63:0] in,
    output wire [6:0]  count
);

wire [3:0] counts [7:0]; // Each popcount is 0..8
wire [6:0] sum1, sum2;

// Instantiate 8 popcount units
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin
        popcount8 u_pop (
            .in    (in[8*i +: 8]),
            .count (counts[i])
        );
    end
endgenerate

// Adder tree (can pipeline if desired)
assign sum1 = counts[0] + counts[1] + counts[2] + counts[3];
assign sum2 = counts[4] + counts[5] + counts[6] + counts[7];
assign count = sum1 + sum2;

endmodule
