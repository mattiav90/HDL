module sort3 #(parameter W=8)(
  input  logic [W-1:0] a, b, c,
  output logic [W-1:0] x, y, z
);

  logic [W-1:0] s0, s1, s2;

  always_comb begin
    // start with the inputs
    s0 = a;
    s1 = b;
    s2 = c;

    // compare-swap (0,1)
    if (s0 > s1) begin
      automatic logic [W-1:0] tmp = s0;
      s0 = s1;
      s1 = tmp;
    end

    // compare-swap (1,2)
    if (s1 > s2) begin
      automatic logic [W-1:0] tmp = s1;
      s1 = s2;
      s2 = tmp;
    end

    // compare-swap (0,1)
    if (s0 > s1) begin
      automatic logic [W-1:0] tmp = s0;
      s0 = s1;
      s1 = tmp;
    end
  end

  assign x = s0;
  assign y = s1;
  assign z = s2;

endmodule
