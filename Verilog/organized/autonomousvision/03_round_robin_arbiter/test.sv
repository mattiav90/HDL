module test();

  localparam N = 8;

  logic clk;
  logic rst;
  logic [N-1:0] req;
  logic [N-1:0] grant;

  // DUT instantiation
  arb #(N) dut (
    .clk   (clk),
    .rst   (rst),
    .req   (req),
    .grant (grant)
  );

  // Clock generator: 10 time units period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Main stimulus
  initial begin
    rst = 1'b1;
    req = '0;

    // hold reset for a couple of cycles
    repeat (2) @(posedge clk);
    rst = 1'b0;

    // list of tests (4-bit patterns)
    gen(4'b0001);
    gen(4'b0010);
    gen(4'b0100);
    gen(4'b1000);
    gen(4'b1010);
    gen(4'b1111);

    $finish;
  end

  // Task: apply a request pattern and observe a few cycles
  task gen(input logic [N-1:0] in);
  begin
    req = in;
    // Let the arbiter run for a few cycles to see round-robin effect
    repeat (4) begin
      @(posedge clk);
      $display("time=%0t  req=%b  grant=%b", $time, req, grant);
    end
    // Optionally drop requests between tests
    req = '0;
    @(posedge clk);
  end
  endtask

  // Wave dump
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
  end

endmodule
