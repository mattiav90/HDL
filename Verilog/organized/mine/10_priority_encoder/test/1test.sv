`timescale 1ns/1ps

module tb_PE_16b;

    logic [15:0] in;
    logic [3:0]  pos;  // $clog2(16) = 4
    logic        val;

    // Instantiate DUT
    PE_16b dut (
        .in(in),
        .pos(pos),
        .val(val)
    );

    initial begin
        $display("Time |        in         | val | pos");
        $display("-----------------------------------");

        // Test each bit set individually (from MSB to LSB)
        for (int i = 15; i >= 0; i--) begin
            in = 16'b0;
            in[i] = 1'b1;
            #1;
            $display("%4t | %b |  %b  | %0d", $time, in, val, pos);
        end

        // Test multiple bits set (should pick MSB)
        in = 16'b1000_0010_0000_0001; #1;
        $display("%4t | %b |  %b  | %0d", $time, in, val, pos);

        // Test all zeros (no valid bits)
        in = 16'b0; #1;
        $display("%4t | %b |  %b  | %0d", $time, in, val, pos);

        $finish;
    end

endmodule
