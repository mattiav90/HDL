module tb_bin2gray;

  localparam int N = 8;

  logic [N-1:0] din;
  logic [N-1:0] dout;

  // DUT
  bin2gray #(.N(N)) dut (
    .din  (din),
    .dout (dout)
  );

  // reference function
  function automatic logic [N-1:0] bin2gray_ref(input logic [N-1:0] b);
    return b ^ (b >> 1);
  endfunction

  initial begin
    // basic sweep
    for (int i = 0; i < (1<<N); i++) begin
      din = i[N-1:0];
      #1;

      if (dout !== bin2gray_ref(din)) begin
        $error("Mismatch: din=%b dout=%b exp=%b",
               din, dout, bin2gray_ref(din));
      end
    end

    // some random tests
    repeat (20) begin
      din = $urandom;
      #1;
      if (dout !== bin2gray_ref(din))
        $error("Random mismatch: din=%b dout=%b", din, dout);
    end

    $display("bin2gray test PASSED");
    $finish;
  end

endmodule
