

// this is the version with the state machine

module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

localparam L=4;

parameter S0=0;
parameter S1=1;
parameter S2=2;
parameter S3=3;
parameter S4=4;


logic [$clog2(L):0] state, next;

always_ff @(posedge clk) begin
  if(~resetn)
    state<=S0;
  else
    state<=next;
end


always_comb begin
  next = 'X;
  case(state)
    S0: next =  din ? S1 : S0;
    S1: next = ~din ? S2 : S1;
    S2: next =  din ? S3 : S0;
    S3: next = ~din ? S4 : S1;
    S4: next =  din ? S3 : S0;
  endcase
end

assign dout = state==S4;


endmodule


// S0 ->(1) S1 ->(0) S2 ->(1) S3 ->(0) S4
// 

