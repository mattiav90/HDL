`timescale 1ns/1ps

module sort3_tb;

  localparam W = 8;

  logic [W-1:0] a, b, c;
  logic [W-1:0] x, y, z;

  sort3 #(W) dut (.a(a), .b(b), .c(c), .x(x), .y(y), .z(z));

  // reference model
  task automatic ref_sort(
    input  logic [W-1:0] ai, bi, ci,
    output logic [W-1:0] r0, r1, r2
  );
    logic [W-1:0] t0, t1, t2, tmp;
    begin
      t0 = ai; t1 = bi; t2 = ci;

      if (t0 > t1) begin tmp=t0; t0=t1; t1=tmp; end
      if (t1 > t2) begin tmp=t1; t1=t2; t2=tmp; end
      if (t0 > t1) begin tmp=t0; t0=t1; t1=tmp; end

      r0 = t0; r1 = t1; r2 = t2;
    end
  endtask

  task automatic run(input int ia, ib, ic);
    logic [W-1:0] e0, e1, e2;
    begin
      a = ia; b = ib; c = ic;
      #1;
      ref_sort(a,b,c,e0,e1,e2);

      if (x!==e0 || y!==e1 || z!==e2)
        $error("FAIL: in=(%0d,%0d,%0d) out=(%0d,%0d,%0d) exp=(%0d,%0d,%0d)",
                a,b,c,x,y,z,e0,e1,e2);
      else
        $display("PASS: in=(%0d,%0d,%0d) → (%0d,%0d,%0d)", a,b,c,x,y,z);
    end
  endtask

  initial begin

    // directed tests
    run(3,1,2);
    run(0,0,0);
    run(5,9,1);
    run(255,10,200);
    run(7,7,1);
    run(1,7,7);

    // random tests
    for (int i=0; i<100; i++)
      run($urandom, $urandom, $urandom);

    $display("DONE");
    $finish;
  end

endmodule
