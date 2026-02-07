
// sequence 10110. overlap.

module FSM_overlap (
	input  logic clk,
	input  logic reset,
	input  logic din,
	output logic det
);

localparam SW=0,S1=1,S10=2,S101=3,S1011=4,S10110=5;
logic [2:0] state,next;

always_ff @(posedge clk) begin
	if(reset)
		state<=SW;
	else
		state<=next;
end


always_comb begin
	case(state)
		SW:		next=  din ? S1     : SW;
		S1:		next= ~din ? S10    : S1;
		S10:	next=  din ? S101   : SW;
		S101:	next=  din ? S1011  : S10;
		S1011:	next= ~din ? S10110 : S1;
		S10110:	next=  din ? S101   : SW;
		default next=SW;
	endcase
end


assign det = state==S10110;

endmodule
