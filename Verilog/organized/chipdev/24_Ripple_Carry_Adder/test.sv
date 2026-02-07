`timescale 1ns/1ps

module tb;

  localparam BW = 32;

  logic [BW-1:0] a;
  logic [BW-1:0] b;
  logic [BW:0]   sum;
  logic [BW-1:0] cout;

  // DUT
  model #(.BW(BW)) dut (
    .a   (a),
    .b   (b),
    .sum (sum),
    .cout(cout)
  );

  // Task: apply a, b and check result vs behavioral a+b
  task automatic apply_and_check(input [BW-1:0] aa,
                                 input [BW-1:0] bb);
    logic [BW:0] expected_sum;
    begin
      a = aa;
      b = bb;
      #1; // allow combinational settle

      expected_sum = {1'b0, aa} + {1'b0, bb};

      if (sum !== expected_sum) begin
        $display("ERROR: a=%h b=%h sum=%h expected=%h",
                 aa, bb, sum, expected_sum);
        $fatal;
      end else begin
        $display("OK   : a=%h b=%h sum=%h",
                 aa, bb, sum);
      end
    end
  endtask

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    // Directed tests
    apply_and_check('0, '0);                      // 0 + 0
    apply_and_check('0, '1);                      // 0 + 1
    apply_and_check('1, '1);                      // all-ones + all-ones
    apply_and_check(32'h0000_0001, 32'h0000_0001);
    apply_and_check(32'hFFFF_FFFF, 32'h0000_0001);
    apply_and_check(32'h1234_5678, 32'h1111_2222);

    // Random tests
    repeat (100) begin
      apply_and_check($random, $random);
    end

    $display("All tests PASSED.");
    $finish;
  end

endmodule
