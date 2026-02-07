module tb;
  timeunit 1ns;
  timeprecision 1ps;

  logic clk, reset;
  logic [7:0]  din;
  logic        in_valid;
  logic        in_ready;
  logic [15:0] dout;
  logic        out_valid;
  logic        out_ready;

  model dut (
    .clk(clk),
    .reset(reset),
    .din(din),
    .in_valid(in_valid),
    .in_ready(in_ready),
    .dout(dout),
    .out_valid(out_valid),
    .out_ready(out_ready)
  );

  // 100 MHz clock
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  initial begin
    // init
    din       = '0;
    in_valid  = 1'b0;
    out_ready = 1'b0;
    reset     = 1'b1;

    repeat (2) @(posedge clk);
    reset = 1'b0;

    // Start ready
    @(negedge clk);
    out_ready = 1'b1;

    send_byte(8'd1);
    send_byte(8'd2);
    send_byte(8'd3);
    send_byte(8'd4);
    send_byte(8'd5);

    // Backpressure output
    @(negedge clk);
    out_ready = 1'b0;

    send_byte(8'd6);
    send_byte(8'd7);
    send_byte(8'd8);

    // Release backpressure
    @(negedge clk);
    out_ready = 1'b1;

    // run a bit then finish
    repeat (20) @(posedge clk);
    $finish;
  end

task automatic send_byte(input logic [7:0] data);
  int unsigned cycles;
  begin
    cycles = 0;

    // wait for ready, but not forever
    while (!in_ready) begin
      @(posedge clk);
      cycles++;
      if (cycles > 200) begin
        $display(1, "[%0t] TIMEOUT waiting in_ready for data=%0d", $time, data);
		$finish;
      end
    end

    @(negedge clk);
    din      = data;
    in_valid = 1'b1;

    @(posedge clk);
    $display("[%0t] IN  : %0d (in_ready=%0b)", $time, data, in_ready);

    @(negedge clk);
    in_valid = 1'b0;
  end
endtask

  // monitor output consumption
  always_ff @(posedge clk) begin
    if (!reset && out_valid && out_ready) begin
      $display("[%0t] OUT : 0x%04h", $time, dout);
    end
  end


  initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
  end

endmodule
