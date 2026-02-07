`timescale 1ns/1ps

module tb_rx2_xor8;

  logic clk;
  logic rst_n;

  logic in_bit;
  logic in_valid;

  logic [7:0] out_data;
  logic       out_valid;

  rx2_xor8 dut (
    .clk      (clk),
    .rst_n    (rst_n),
    .in_bit   (in_bit),
    .in_valid (in_valid),
    .out_data (out_data),
    .out_valid(out_valid)
  );

  // clock
  always #5 clk = ~clk;

  initial begin
    // init
    clk = 0;
    rst_n = 0;
    in_bit = 0;
    in_valid = 0;

    // reset
    repeat (2) @(negedge clk);
    rst_n = 1;

    // w0 = 8'hA5 = 1010_0101 (LSB-first)
    @(negedge clk); in_bit = 1; in_valid = 1;
    @(negedge clk); in_bit = 0;
    @(negedge clk); in_bit = 1;
    @(negedge clk); in_bit = 0;
    @(negedge clk); in_bit = 0;
    @(negedge clk); in_bit = 1;
    @(negedge clk); in_bit = 0;
    @(negedge clk); in_bit = 1;

    // w1 = 8'h3C = 0011_1100 (LSB-first)
    @(negedge clk); in_bit = 0;
    @(negedge clk); in_bit = 0;
    @(negedge clk); in_bit = 1;
    @(negedge clk); in_bit = 1;
    @(negedge clk); in_bit = 1;
    @(negedge clk); in_bit = 1;
    @(negedge clk); in_bit = 0;
    @(negedge clk); in_bit = 0;

    @(negedge clk);
    in_valid = 0;

    // output is one-cycle late → check after one posedge
    @(posedge clk);

    if (out_valid && out_data == (8'hA5 ^ 8'h3C))
      $display("PASS: out_data = %h", out_data);
    else
      $display("FAIL: out_valid=%0b out_data=%h (expected %h)",
               out_valid, out_data, (8'hA5 ^ 8'h3C));

    #20 $finish;
  end

  initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
  end

endmodule
