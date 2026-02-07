
// detect the sequence 10110 and do not allow overlap

module FSM_non_overlap (
  input  logic clk,
  input  logic reset,
  input  logic din,
  output logic det
);


  localparam S =0;
  localparam S1 =1;
  localparam S10 =2;
  localparam S101 =3;
  localparam S1011 =4;
  
  logic [2:0] state ,next;


  always_ff @(posedge clk) begin
    if (reset) state <= S;
    else       state <= next;
  end

  always_comb begin
    unique case (state)
      S:     next = din ? S1    : S;
      S1:    next = din ? S1    : S10;
      S10:   next = din ? S101  : S;
      S101:  next = din ? S1011 : S;
      S1011: next = din ? S1    : S;   // non-overlap on completion
      default: next = S;
    endcase
  end

  // pulse when last bit (0) arrives after being in S1011
  assign det = (state == S1011) && (din == 1'b0);

endmodule
