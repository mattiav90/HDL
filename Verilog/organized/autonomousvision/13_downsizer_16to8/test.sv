`timescale 1ns/1ps

module tb_in32_out1;

  logic clk, rst;
  logic [31:0] din;
  logic valid;
  logic out;
  logic ready;

  // DUT
  in32_out1 dut (
    .clk   (clk),
    .rst   (rst),
    .din   (din),
    .valid (valid),
    .out   (out),
    .ready (ready)
  );

  // Clock generator
  always #5 clk = ~clk;

  // -------------------------
  // TASK: apply 1 transaction
  // -------------------------
  task do_load(input int value);
    begin
      @(posedge clk);
      din   = value;
      valid = 1;
      $display("[%0t] Load request: din=%0d", $time, value);

      @(posedge clk);
      valid = 0;
      din=0;
    end
  endtask

  // -------------------------
  // MAIN TB
  // -------------------------
  initial begin
    clk   = 0;
    rst   = 1;
    din   = 0;
    valid = 0;

    // Reset sequence
    repeat(3) @(posedge clk);
    rst = 0;


    //data
    repeat(3) @(posedge clk);
    do_load(32'b10101011111010101111101010101010);

    // data
    repeat(50) @(posedge clk);
    do_load(32'b00000000111111110000000011111111);


	//data
    repeat(10) @(posedge clk);
    do_load(32'b11110001010101010000001111111111);
    

    repeat(20) @(posedge clk);
    
    $display("\nTestbench completed.");
    $finish;
  end

  initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
  end

endmodule
