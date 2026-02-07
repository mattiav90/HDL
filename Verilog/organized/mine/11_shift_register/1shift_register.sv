module shift_reg #(
    parameter W = 1,    // Data width
    parameter N = 4     // Shift length
)(
    input  logic             clk,
    input  logic             resetn,
    input  logic [W-1:0]     din,
    output logic [W-1:0]     dout
);

    logic [W-1:0] sr [0:N-1];

    always_ff @(posedge clk) begin
        if (!resetn) begin
            sr <= '{default:0};
        end else begin
            sr[0] <= din;
            for (int i = 1; i < N; i++) begin
                sr[i] <= sr[i-1];
            end
        end
    end

    assign dout = sr[N-1];
endmodule
