module model_ok (
  input  logic        clk,
  input  logic        resetn,

  // left: valid + credit-return (1-word buffer)
  input  logic        valid_L,
  output logic        credit_L,     // pulse: buffer freed
  input  logic [15:0] in_data,

  // right: valid + credit (credit = consumed)
  output logic        valid_R,
  output logic        out_data,
  input  logic        credit_R
);

  logic [15:0] data;
  logic [3:0]  count;
  logic        capture;

  always_ff @(posedge clk) begin
    if (!resetn) begin
      data     <= 0;
      count    <= 0;
      capture  <= 0;
      credit_L <= 0;
    end else begin
    
      credit_L <= 0;

      // accept new word if buffer empty
      if (!capture && valid_L) begin
        data    <= in_data;
        count   <= 0;
        capture <= 1;
      end

      // advance when right consumes
      if (capture && credit_R) begin
      
        if (count == 15) begin
          count    <= 0;
          capture  <= 0;   // buffer freed
          credit_L <= 1;   // return credit
        end else begin
          count <= count + 1;
        end

        
      end
    end
  end

  assign valid_R  = capture;
  assign out_data = data[count];

endmodule
