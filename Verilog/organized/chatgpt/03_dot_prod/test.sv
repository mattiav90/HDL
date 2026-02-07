// tb_dot_product_stream.sv
`timescale 1ns/1ps

module tb_dot_product_stream;

  localparam int W  = 8;
  localparam int K  = 4;
  localparam int ACCW = 2*W + $clog2(K+1);

  logic clk;
  logic rst_n;
  logic clear;

  logic signed [W-1:0] a_data;
  logic                a_valid;
  logic                a_ready;

  logic signed [W-1:0] b_data;
  logic                b_valid;
  logic                b_ready;

  logic signed [ACCW-1:0] out_data;
  logic                   out_valid;
  logic                   out_ready;

  dot_product_stream #(
    .W(W),
    .K(K)
  ) dut (
    .clk      (clk),
    .rst_n    (rst_n),
    .clear    (clear),
    .a_data   (a_data),
    .a_valid  (a_valid),
    .a_ready  (a_ready),
    .b_data   (b_data),
    .b_valid  (b_valid),
    .b_ready  (b_ready),
    .out_data (out_data),
    .out_valid(out_valid),
    .out_ready(out_ready)
  );

  always #5 clk = ~clk;

  task reset_dut;
    begin
      clk = 0;
      rst_n = 0;
      clear = 0;

      a_data = '0; b_data = '0;
      a_valid = 0; b_valid = 0;
      out_ready = 0;

      repeat (2) @(posedge clk);
      rst_n = 1;
      @(posedge clk);
    end
  endtask

  task send_pair(input int a, input int b);
    begin
      a_data  = a;
      b_data  = b;
      a_valid = 1;
      b_valid = 1;

      while (!(a_ready && b_ready))
        @(posedge clk);

      @(posedge clk);
      a_valid = 0;
      b_valid = 0;
    end
  endtask

  task expect_out(input int exp);
    begin
      // backpressure for one cycle
      out_ready = 0;
      @(posedge clk);
      out_ready = 1;

      while (!out_valid)
        @(posedge clk);

      if (out_data !== exp)
        $display("ERROR exp=%0d got=%0d", exp, out_data);
      else
        $display("PASS out=%0d", out_data);

      @(posedge clk); // consume
    end
  endtask

  initial begin
    reset_dut();

    // Dot: [1,2,3,4] · [5,6,7,8] = 70
    send_pair(1,5);
    send_pair(2,6);
    send_pair(3,7);
    send_pair(4,8);
    expect_out(70);

    // Clear mid-way and restart: should drop partial
    clear = 1;
    @(posedge clk);
    clear = 0;

    // Dot: [1,1,1,1] · [2,2,2,2] = 8
    send_pair(1,2);
    send_pair(1,2);
    send_pair(1,2);
    send_pair(1,2);
    expect_out(8);

    $display("DONE");
    #20 $finish;
  end

  initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
  end
endmodule
