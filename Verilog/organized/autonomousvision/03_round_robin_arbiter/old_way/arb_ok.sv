module arb_ok #(
  parameter int N = 4
)(
  input  logic         clk,
  input  logic         rst,     // active-high synchronous reset
  input  logic [N-1:0] req,
  output logic [N-1:0] grant
);

  logic [$clog2(N)-1:0] ptr, ptr_next;

  // Pointer register
  always_ff @(posedge clk) begin
    if (rst)
      ptr <= '0;
    else
      ptr <= ptr_next;
  end

  // Combinational: compute grant and next pointer
  always_comb begin
    int  k;
    int  idx;
    logic found;

    grant    = '0;
    ptr_next = ptr;
    found    = 0;

    // Scan starting from ptr, wrapping around
    for (k = 0; k < N; k++) begin
      idx = ptr + k;
      
      if (idx >= N) idx = idx - N;           // wrap

      if (!found && req[idx]) begin
        grant[idx] = 1'b1;
        found      = 1;

        // next priority starts after granted index (wrap)
        ptr_next = idx==N-1 ? 0 : idx+1;
        
      end
    end
  end

endmodule
