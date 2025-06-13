

// catch patter 010

module pattern_fsm1 (
	input wire clk,
	input wire rstn,
	input wire data_in,
	output reg match
);

localparam S0 = 3'b001;		//use one hot incoding to simplify state matching logic.
localparam S1 = 3'b010;
localparam S2 = 3'b100;

reg [2:0] state;


//combine the various always statements if you want less latency.
//do not use extra pipelining if you want less latency.
// combine output and transition logic to reduce delay.
always @ (posedge clk or negedge rstn) begin
if(!rstn) begin
	state<=S0;
	match<=0;
end else begin

	case (state)
		S0: begin
			state<= data_in ? S0 : S1;	//notice that here I am not using comparators.
			match<=0;
			end
		S1: begin
			state<= data_in ? S2 : S1; // I just use the stright wire. that makes it faster
			match<=0;
			end
		S2: begin
			state<= data_in ? S0 : S1;
			match<= !data_in;          //also here I do not use comparators. only wire.
			end
		default: begin
				state<=S0;
				match<=0;
				end
	endcase
	
end
end



endmodule
