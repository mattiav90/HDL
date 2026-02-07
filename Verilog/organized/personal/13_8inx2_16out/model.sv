module model (
  input  logic        clk,
  input  logic        reset,

  input  logic [7:0]  din,
  input  logic        in_valid,
  output logic        in_ready,

  output logic [15:0] dout,
  output logic        out_valid,
  input  logic        out_ready
);

  logic        c;
  logic [7:0]  lo;

  // Can accept input if no pending output, or if output will be consumed now
  assign in_ready = !out_valid || out_ready;

  always_ff @(posedge clk) begin
    if (reset) begin
      c         <= 1'b0;
      lo        <= '0;
      dout      <= '0;
      out_valid <= 1'b0;
    end else begin
      // consume output
      if (out_valid && out_ready)
        out_valid <= 0;

      // accept input
      if (in_valid && in_ready) begin
      	
        if (!c) begin
          lo      <= din;
          c       <= 1;
        end else begin
          dout      <= {din, lo};   // {second, first}
          out_valid <= 1;
          c         <= 0;
        end
        
      end

      
    end
  end

endmodule
