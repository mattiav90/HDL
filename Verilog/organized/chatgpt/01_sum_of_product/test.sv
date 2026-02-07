`timescale 1ns/1ps
module tb;

  parameter BW=8;
  parameter K =5;

  reg clk, reset;
  reg  [BW-1:0] x, w;
  reg  in_valid;
  wire in_ready;

  wire [(BW*2+K):0] out;
  wire out_valid;
  reg  out_ready;

  model #(.BW(BW),.K(K)) dut (
    .clk(clk), 
    .reset(reset),
    .x(x), 
    .w(w),
    .in_valid(in_valid), 
    .in_ready(in_ready),
    .out(out), 
    .out_valid(out_valid), 
    .out_ready(out_ready)
  );

  integer i;
  reg [31:0] exp;

  always #5 clk = ~clk;


  // resett;
  task resett;
  begin
	  clk=0; reset=1;
	  x=0; 
	  w=0; 
	  in_valid=0; 
	  out_ready=0; 
	  exp=0;
	  @(posedge clk);
	  @(posedge clk);
	  reset=0;
  end
  endtask



  
  initial begin

	resett;

	// the output cannnot receive yet
    out_ready=0;

    // push K samples
    in_valid=1;
    for (i=0; i<K; i=i+1) begin

      @(negedge clk);
      x = i;
      w = i+1;
      if (!in_ready) begin
        $display("FAIL: in_ready low during accumulate");
        $finish;
      end
      @(posedge clk);
      exp = exp + (x*w);
    end
    in_valid=0;


    repeat(5); @(posedge clk);
    
	//the output can receive
	@(negedge clk); out_ready=1;


    #20;
    $finish;
  end

  initial begin
	$dumpfile("wave.vcd");
	$dumpvars();
  end

endmodule
