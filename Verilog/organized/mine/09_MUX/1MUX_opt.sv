module mux_tree #(
    parameter W  = 64,
    parameter IN = 32
)(
    input  logic [W-1:0] inputs [0:IN-1],
    input  logic [$clog2(IN)-1:0] sel,
    output logic [W-1:0] out
);
	parameter STAGES=$clog2(IN);
	
    logic [W-1:0] stage [0:STAGES][0:IN-1];

    // Stage 0 = original inputs
    generate
        for (genvar i = 0; i < IN; i++) begin
            assign stage[0][i] = inputs[i];
        end
    endgenerate


    // Each stage halves the number of signals
    genvar s,i;
    generate
        for (s = 0; s < STAGES; s++) begin
            for (i = 0; i < (IN>>s+1); i++) begin
                assign stage[s+1][i] = sel[s] ? stage[s][2*i+1] : stage[s][2*i];
            end
        end
    endgenerate

    assign out = stage[STAGES][0];
endmodule
