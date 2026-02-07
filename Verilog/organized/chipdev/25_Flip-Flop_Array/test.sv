`timescale 1ns/1ps

module tb_model;

  // DUT interface signals
  logic        clk;
  logic        resetn;
  logic [7:0]  din;
  logic [2:0]  addr;
  logic        wr;
  logic        rd;
  logic [7:0]  dout;
  logic        error;

  // Instantiate DUT
  model dut (
    .clk    (clk),
    .resetn (resetn),
    .din    (din),
    .addr   (addr),
    .wr     (wr),
    .rd     (rd),
    .dout   (dout),
    .error  (error)
  );

  // Clock generation: 10 ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Simple tasks for readability
  task automatic apply_reset();
    begin
      resetn = 0;
      din    = '0;
      addr   = '0;
      wr     = 0;
      rd     = 0;
      @(posedge clk);
      @(posedge clk);
      resetn = 1;
      @(posedge clk);
    end
  endtask

  task automatic write_mem(input [2:0] a, input [7:0] d);
    begin
      @(posedge clk);
      addr = a;
      din  = d;
      wr   = 1;
      rd   = 0;
      @(posedge clk);    // perform write
      wr   = 0;
      din  = '0;
    end
  endtask

  task automatic read_mem(input [2:0] a, input [7:0] expected);
    begin
      @(posedge clk);
      addr = a;
      wr   = 0;
      rd   = 1;
      @(posedge clk);    // perform read
      rd   = 0;

      // Check
      if (dout !== expected) begin
        $error("READ MISMATCH at time %0t: addr=%0d expected=0x%0h got=0x%0h",
               $time, a, expected, dout);
      end else begin
        $display("READ OK at time %0t: addr=%0d value=0x%0h",
                 $time, a, dout);
      end

      if (error !== 0) begin
        $error("ERROR signal asserted unexpectedly at time %0t", $time);
      end
    end
  endtask

  task automatic idle_cycle();
    begin
      @(posedge clk);
      wr = 0;
      rd = 0;
      din = '0;
    end
  endtask

  initial begin
    // Initialize
    resetn = 0;
    din    = '0;
    addr   = '0;
    wr     = 0;
    rd     = 0;

    // Apply reset and check memory cleared
    apply_reset();

    // After reset, all mem entries should be 0.
    // We'll read a few to confirm.
    read_mem(3'd0, 8'h00);
    read_mem(3'd7, 8'h00);

    // Write some values
    write_mem(3'd0, 8'hAA);
    write_mem(3'd3, 8'h55);
    write_mem(3'd7, 8'hFF);

    // Idle cycle (no rd, no wr) -> dout and error should be 0
    idle_cycle();
    if (dout !== 8'h00 || error !== 1'b0) begin
      $error("Idle behavior incorrect at time %0t: dout=0x%0h error=%0b",
             $time, dout, error);
    end

    // Read back and check
    read_mem(3'd0, 8'hAA);
    read_mem(3'd3, 8'h55);
    read_mem(3'd7, 8'hFF);

    // Test illegal condition: wr and rd both high -> error=1, dout=0
    @(posedge clk);
    addr = 3'd2;
    din  = 8'h12;
    wr   = 1;
    rd   = 1;
    @(posedge clk);
    wr   = 0;
    rd   = 0;
    din  = '0;

    if (error !== 1'b1 || dout !== 8'h00) begin
      $error("Illegal wr&rd behavior incorrect at time %0t: dout=0x%0h error=%0b",
             $time, dout, error);
    end else begin
      $display("Illegal wr&rd condition correctly asserted error at time %0t", $time);
    end

    // Final idle check clears error and dout
    idle_cycle();
    if (dout !== 8'h00 || error !== 1'b0) begin
      $error("Post-error idle behavior incorrect at time %0t: dout=0x%0h error=%0b",
             $time, dout, error);
    end

    $display("All tests completed at time %0t", $time);
    $finish;
  end

endmodule
