module tb_pulse_sync;

  // clocks
  logic clk_a;
  logic clk_b;

  // signals
  logic arstn;
  logic pls_a;
  logic pls_b;

  // DUT
  pulse_sync dut (
    .clk_a (clk_a),
    .clk_b (clk_b),
    .arstn (arstn),
    .pls_a (pls_a),
    .pls_b (pls_b)
  );

  // clock A: 10 ns period
  initial clk_a = 0;
  always #3 clk_a = ~clk_a;

  // clock B: 14 ns period (async to clk_a)
  initial clk_b = 0;
  always #10 clk_b = ~clk_b;

  // stimulus
  initial begin
    // init
    arstn = 0;
    pls_a = 0;

    // release reset
    #20;
    arstn = 1;

    // generate pulses in clk_a domain
    repeat (2) @(posedge clk_a);

    pulse_a();
    repeat (5) @(posedge clk_a);

    pulse_a();
    repeat (3) @(posedge clk_a);

    pulse_a();
    repeat (10) @(posedge clk_a);

    $finish;
  end

  // task: generate 1-cycle pulse in clk_a domain
  task pulse_a;
    begin
      @(posedge clk_a);
      pls_a = 1'b1;
      @(posedge clk_a);
      pls_a = 1'b0;
    end
  endtask

  // optional monitor
  initial begin
    $display("time   clk_a pls_a | clk_b pls_b");
    $monitor("%4t    %b     %b   |   %b     %b",
              $time, clk_a, pls_a, clk_b, pls_b);
  end

  initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
  end

endmodule
