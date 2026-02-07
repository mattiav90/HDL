`timescale 1ns/1ps

module fifo_tb;

  localparam N = 8;
  localparam D = 16;

  logic clk, rst;
  logic wr, rd;
  logic [N-1:0] din;
  logic [N-1:0] dout;
  logic full, empty;

  // DUT
  fifo #(N, D) dut (
    .clk, .rst, .wr, .rd, .din, .dout,
    .full, .empty
  );

  always #5 clk = ~clk;

  // -------------------------
  // Write until FIFO full
  // -------------------------
  task fill_fifo;
    begin
      int val = 0;
      $display("\n--- Filling FIFO ---");
      while (!full) begin
        @(negedge clk);
        wr  = 1;
        rd  = 0;
        din = val;
        @(posedge clk);
        $display("Wrote %0d  (full=%0b)", val, full);
        val++;
      end
      wr = 0;
      $display("FIFO full.\n");
    end
  endtask

  // -------------------------
  // Read until FIFO empty
  // -------------------------
  task drain_fifo;
    begin
      $display("\n--- Draining FIFO ---");
      while (!empty) begin
        @(negedge clk); 
        wr = 0;
        rd = 1;
        @(posedge clk);
        $display("Read %0d  (empty=%0b)", dout, empty);
      end
      rd = 0;
      $display("FIFO empty.\n");
    end
  endtask

  // -------------------------
  // Simultaneous read + write
  // -------------------------
  task simul_rw;
    begin
      $display("\n--- Simultaneous Read/Write ---");
      for (int i = 0; i < 5; i++) begin
        @(negedge clk);
        wr  = 1;
        rd  = 1;
        din = 100 + i;
        @(posedge clk);
        $display("Wrote %0d   Read %0d   (full=%0b empty=%0b)",
                 100+i, dout, full, empty);
      end
      wr = 0;
      rd = 0;
      $display("Simultaneous RW phase done.\n");
    end
  endtask

  // -------------------------
  // Test Sequence
  // -------------------------
  initial begin
    clk = 0;
    rst = 1;
    wr  = 0;
    rd  = 0;
    din = 0;

    // Reset
    repeat (3) @(posedge clk);
    rst = 0;

    fill_fifo();       // write until full
    simul_rw();        // read & write at same time
    drain_fifo();      // read until empty

    $finish;
  end

endmodule
