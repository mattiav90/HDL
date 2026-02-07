`timescale 1ns/1ps

module test;

    parameter W = 64;
    logic [W-1:0] in;
    logic [$clog2(W+1)-1:0] count;
    logic [$clog2(W+1)-1:0] temp;

    integer i;

    // DUT instantiation (assuming module is named naive and uses parameter WIDTH)
    popcount_tree #(.W(W)) pop (
        .in(in),
        .count(count)
    );

    // Task to check one random input
    task go;
        begin
            in = $random;
            temp = 0;
            for (i = 0; i < W; i++) begin
                temp = temp + in[i];
            end

            #1; // allow combinational logic to settle

            if (temp == count) begin
                $display("OK.    in: %b count: %0d", in, count);
            end else begin
                $display("ERROR. in: %b count: %0d check: %0d", in, count, temp);
            end
        end
    endtask;

    // Test sequence
    initial begin
        repeat (10) go;
        $finish;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

endmodule
