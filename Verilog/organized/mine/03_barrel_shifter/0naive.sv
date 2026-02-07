module naive #(
    parameter WIDTH = 32
) (
    input  logic [WIDTH-1:0] data_in,
    input  logic [$clog2(WIDTH)-1:0] shift_amount,
    output logic [WIDTH-1:0] data_out
);
    always_comb begin
        data_out = data_in << shift_amount;  // synthesizes, but usually slow!
    end
endmodule
