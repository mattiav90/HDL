module popcount_tree_pipe #(
    parameter W = 64
) (
    input  logic                     clk,
    input  logic                     rst,
    input  logic [W-1:0]              in,
    output logic [$clog2(W+1)-1:0]    count
);

    localparam STAGES = $clog2(W);

    // Stage arrays: [stage index][element index]
    logic [$clog2(W+1)-1:0] stage   [0:STAGES][W-1:0];

    genvar i, s;

    // Stage 0: individual bits as integers
    generate
        for (i = 0; i < W; i++) begin
            always_ff @(posedge clk) begin
                if (rst)
                    stage[0][i] <= '0;
                else
                    stage[0][i] <= in[i];
            end
        end

        // Adder tree with pipeline registers between stages
        for (s = 0; s < STAGES; s++) begin : stage_loop
            localparam CUR_WIDTH  = (W >> s);
            localparam NEXT_WIDTH = (CUR_WIDTH + 1) / 2;

            for (i = 0; i < NEXT_WIDTH; i++) begin : sum_loop
                always_ff @(posedge clk) begin
                    if (rst)
                        stage[s+1][i] <= '0;
                    else
                        stage[s+1][i] <= stage[s][2*i] + ((2*i+1 < CUR_WIDTH) ? stage[s][2*i+1] : '0);
                end
            end
        end
    endgenerate

    // Output after final stage
    assign count = stage[STAGES][0];

endmodule
