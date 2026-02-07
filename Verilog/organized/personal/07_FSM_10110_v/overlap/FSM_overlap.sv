
// detect the sequence 10110, and allow overlapping

module FSM_overlap (
	input logic clk,
	input logic reset,
	input logic din,
	output logic det
);


	localparam S=0;
	localparam S1=1;
	localparam S10=2;
	localparam S101=3;
	localparam S1011=4;
	localparam S10110=5;


	logic [2:0] state,next;
		


	always_ff @(posedge clk) begin
		if(reset)
			state<=S;
		else
			state<=next;
	end

	always_comb begin
		next=S;
		case(state)
			S: 		next = din ? S1 : S;
			S1:		next = din ? S1 : S10;
			S10:	next = din ? S101 : S;
			S101:	next = din ? S1011 : S10;
			S1011:	next = din ? S1 : S10110;
			S10110:	next = din ? S101 : S;
		endcase
	end

	assign det = state==S10110;


endmodule
