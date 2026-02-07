

module tb_median;

  localparam int N = 8;

  logic [N-1:0] a, b, c;
  logic [N-1:0] out;

  // DUT
  median #(.N(N)) dut (
    .a   (a),
    .b   (b),
    .c   (c),
    .out (out)
  );

  // reference function
  function automatic logic [N-1:0] median_ref(
    input logic [N-1:0] x,
    input logic [N-1:0] y,
    input logic [N-1:0] z
  );
    if ((x >= y && x <= z) || (x <= y && x >= z)) return x;
    else if ((y >= x && y <= z) || (y <= x && y >= z)) return y;
    else return z;
  endfunction

  initial begin
    // directed tests
    test_vec(3, 5, 4);
    test_vec(9, 1, 5);
    test_vec(7, 7, 2);
    test_vec(0, 255, 128);

    // random tests
    repeat (50) begin
      a = $urandom;
      b = $urandom;
      c = $urandom;
      #1;
      if (out !== median_ref(a,b,c))
        $error("FAIL: a=%0d b=%0d c=%0d out=%0d",
               a, b, c, out);
    end

    $display("Median test PASSED");
    $finish;
  end

  task test_vec(
    input logic [N-1:0] x,
    input logic [N-1:0] y,
    input logic [N-1:0] z
  );
    begin
      a = x; b = y; c = z;
      #1;
      if (out !== median_ref(a,b,c))
        $error("FAIL: a=%0d b=%0d c=%0d out=%0d",
               a, b, c, out);
    end
  endtask

endmodule
