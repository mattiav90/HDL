// N-input round-robin arbiter
// Technique: scan from pointer, grant first request, advance pointer.
// Combinational grant, registered pointer.

module arb #(parameter int N = 8)(
  input  logic         clk,
  input  logic         rst,
  input  logic [N-1:0] req,
  output logic [N-1:0] grant
);

  localparam PTR_W = $clog2(N);

  logic [PTR_W-1:0] pointer, next;
  logic             found;


  always_ff @(posedge clk) begin
    if (rst) begin
      pointer <= '0;
    end else begin
      pointer <= next;
    end
  end

  
  always_comb begin
    grant     = '0;
    next = pointer;
    found     = 0;

    // Scan requests starting from pointer
    for (int i = 0; i < N; i++) begin
      int index;
      index = (pointer + i) % N;

      if (!found && req[index]) begin
        grant[index] = 1'b1;
        next   = (index + 1) % N;
        found       = 1'b1;   // emulates break
      end
    end
  end


endmodule
