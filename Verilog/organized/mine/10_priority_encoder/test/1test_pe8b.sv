

`timescale 1ns/1ps

module tb_PE_8b;

    logic [7:0] in;
    logic [2:0] pos;
    logic       val;

    // DUT
    PE_8b dut (
        .in(in),
        .pos(pos),
        .val(val)
    );

    initial begin
        $display("Time |   in      | pos | val");
        $display("-----------------------------");

        // Test with only one bit set at each position
        for (int i = 0; i < 8; i++) begin
            in = 8'b1 << i;
            #1 $display("%4t | %b |  %0d  |  %0d", $time, in, pos, val);
        end

        // Test with multiple bits set (MSB priority)
        in = 8'b10101010; #1;
        $display("%4t | %b |  %0d  |  %0d", $time, in, pos, val);

        in = 8'b00011000; #1;
        $display("%4t | %b |  %0d  |  %0d", $time, in, pos, val);

        // Test with all zeros
        in = 8'b00000000; #1;
        $display("%4t | %b |  %0d  |  %0d", $time, in, pos, val);

        $finish;
    end

endmodule
