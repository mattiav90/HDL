module test();

  reg        clk, reset;
  reg  [7:0] din;
  wire [31:0] out;

  Fibonacci dut (
	.clk(clk),
	.reset(reset),
	.din(din),
	.out(out)
	);

  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end



  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, test);
  end

  // fibonacci function
  function [31:0] fib(input [7:0] n);
    logic  [31:0] a, b, t;
    integer i;
    
    begin
      a = 0; b = 1;
      if (n == 0) fib = 0;
      else if (n == 1) fib = 1;
      else begin
        for (i = 2; i <= n; i = i + 1) begin
          t = a + b;
          a = b;
          b = t;
        end
        fib = b;
      end
    end
  endfunction

  
  // generate an input and check if is is correct. 
  task gen_n;
    input [7:0] n;
    reg [31:0] exp32;
    begin
      @(negedge clk);
      din = n;

      @(negedge clk);   // adjust if DUT latency > 1

      exp32 = fib(n);

      if (out !== exp32)
        $display("FAIL: n=%0d out=%0d exp=%0d", n, out, exp32);
      else
        $display("PASS: n=%0d out=%0d", n, out);
    end
  endtask


  

  initial begin
    reset = 1;
    din   = 0;
    repeat (2) @(posedge clk);
    reset = 0;


    gen_n(8'd0);
    gen_n(8'd1);
    gen_n(8'd2);
    gen_n(8'd3);
    gen_n(8'd4);
    gen_n(8'd5);
    gen_n(8'd6);
    gen_n(8'd7);
    gen_n(8'd8);
    gen_n(8'd9);
    gen_n(8'd10);

    repeat (10) @(posedge clk);

    $display("END OF TEST reached at t=%0t", $time);
    #10;
    $finish;
  end

endmodule
