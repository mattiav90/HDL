module popcount_tree #(
    parameter W = 64
) (
    input  logic [W-1:0] in,
    output logic [$clog2(W+1)-1:0] count
);

    localparam STAGES = $clog2(W);

    // Stage arrays: [stage index][element index]
    logic [$clog2(W+1)-1:0] stage   [0:STAGES][W-1:0];

    // Stage 0: individual bits as integers
    genvar i, s;
    generate
        for (i = 0; i < W; i++) begin
            assign stage[0][i] = in[i];
        end

        // Adder tree
        for (s = 0; s < STAGES; s++) begin : stage_loop
            localparam CUR_WIDTH  = (W >> s);
            localparam NEXT_WIDTH = (CUR_WIDTH + 1) / 2;

            
            for (i = 0; i < NEXT_WIDTH; i++) begin : sum_loop
              	assign stage[s+1][i] = stage[s][i*2] + ((2*i+1 < CUR_WIDTH) ? stage[s][2*i+1] : 0);
            end
        end
    endgenerate

    assign count = stage[STAGES][0];

endmodule
