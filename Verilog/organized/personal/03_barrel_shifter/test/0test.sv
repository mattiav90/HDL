`timescale 1ns/1ps

module tb_naive_shift;

    localparam WIDTH = 32;
    localparam AMT_BITS = $clog2(WIDTH);

    logic [WIDTH-1:0] data_in;
    logic [AMT_BITS-1:0] shift_amount;
    logic [WIDTH-1:0] dut_out;
    logic [WIDTH-1:0] golden;

    // DUT instance
    naive #(
        .W(WIDTH)
    ) dut (
        .in(data_in),
        .shift(shift_amount),
        .out(dut_out)
    );

    integer i;
    initial begin
        $display("Testing Naive Barrel Shifter...");
        for (i = 0; i < 1000; i++) begin
            data_in      = $urandom();
            shift_amount = $urandom_range(0, WIDTH-1);
            golden       = data_in << shift_amount; // golden reference

            #1; // let combinational logic settle

            if (dut_out !== golden) begin
                $error("Mismatch at test %0d: in=%h shift=%0d DUT=%h GOLD=%h",
                       i, data_in, shift_amount, dut_out, golden);
                $stop;
                
            end
        end
        $display("Naive Barrel Shifter passed all %0d tests!", i);
        $finish;
    end

endmodule
