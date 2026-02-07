module popcount8 (
    input  wire [7:0] in,
    output wire [3:0] count
);
    assign count = in[0] + in[1] + in[2] + in[3] +
                   in[4] + in[5] + in[6] + in[7];
endmodule



module bit_counter_chunks_pipeline (
    input  wire        clk,
    input  wire        resetn,
    input  wire [63:0] in,
    output reg  [6:0]  count
);

// Combinational popcount8 units
wire [3:0] counts [7:0];
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : POP8
        popcount8 u_pop (
            .in    (in[8*i +: 8]),
            .count (counts[i])
        );
    end
endgenerate

// Stage 1: partial sums
reg [4:0] sum_a1, sum_a2, sum_b1, sum_b2;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        sum_a1 <= 0;
        sum_a2 <= 0;
        sum_b1 <= 0;
        sum_b2 <= 0;
    end else begin
        sum_a1 <= counts[0] + counts[1];
        sum_a2 <= counts[2] + counts[3];
        sum_b1 <= counts[4] + counts[5];
        sum_b2 <= counts[6] + counts[7];
    end
end

// Stage 2: intermediate sums
reg [5:0] sum_left, sum_right;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        sum_left  <= 0;
        sum_right <= 0;
    end else begin
        sum_left  <= sum_a1 + sum_a2;
        sum_right <= sum_b1 + sum_b2;
    end
end

// Stage 3: final sum
always @(posedge clk or negedge resetn) begin
    if (!resetn)
        count <= 0;
    else
        count <= sum_left + sum_right;
end

endmodule
