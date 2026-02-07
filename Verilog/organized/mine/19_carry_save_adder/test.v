`timescale 1ns/1ps

module tb_carry_save_adder;

    parameter W = 8;

    reg  [W-1:0] a, b, c;
    wire [W-1:0] sum, carry;
    reg  [W:0]   expected_total;
    reg  [W:0]   csa_result;

    // DUT
    add_carry_save #(W) dut (
        .a(a),
        .b(b),
        .c(c),
        .sum(sum),
        .carry(carry)
    );

    integer i;

    initial begin
        $display("==== Carry Save Adder Testbench ====");

        // Run 10 random test cases
        for (i = 0; i < 10; i = i + 1) begin
            a = $random;
            b = $random;
            c = $random;

            #1; // Small delay to let logic settle

            expected_total = a + b + c;
            csa_result = sum + (carry << 1);

            $display("Test %0d | a=%0d b=%0d c=%0d | sum=%0d carry=%0d -> final=%0d (expected=%0d)",
                i, a, b, c, sum, carry, csa_result, expected_total
            );

            if (csa_result !== expected_total) begin
                $display("MISMATCH at test %0d", i);
                $stop;
            end
        end

        $display("All tests passed.");
        $finish;
    end

endmodule
