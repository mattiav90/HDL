`timescale 1ns/1ps

module gray2binary_tb;

  localparam N = 16;

  logic [N-1:0] din;
  logic [N-1:0] dout;

  // DUT
  gray2binary #(N) dut (
    .din(din),
    .dout(dout)
  );

  // Reference model: Gray -> Binary
  function automatic [N-1:0] gray2bin_ref(input [N-1:0] g);
    logic [N-1:0] b;
    begin
      b[N-1] = g[N-1];
      for (int i = N-2; i >= 0; i--) begin
        b[i] = b[i+1] ^ g[i];
      end
      return b;
    end
  endfunction

  // Simple check task
  task automatic check(input [N-1:0] g);
    logic [N-1:0] exp;
    begin
      din = g;
      #1; // allow combinational logic to settle
      exp = gray2bin_ref(g);
      if (dout !== exp) begin
        $error("Mismatch for din=%0h: got dout=%0h, expected %0h",
               g, dout, exp);
      end else begin
        $display("OK: din=%0h -> dout=%0h", g, dout);
      end
    end
  endtask

  initial begin
    // A few fixed patterns
    check('0);
    check({N{1'b1}});
    check(16'h0001);
    check(16'h0002);
    check(16'h00F0);
    check(16'h0F0F);
    check(16'hAAAA);
    check(16'h5555);

    // Random tests
    for (int i = 0; i < 100; i++) begin
      check($urandom);
    end

    $display("All tests completed.");
    $finish;
  end

endmodule
