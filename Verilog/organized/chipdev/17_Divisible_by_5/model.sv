

module model (
	input clk,
	input resetn,
	input din,
	output dout
);


// typedef enum logic [2:0] {
//	MODR=0,
//	MOD0=1,
//	MOD1=2,
//	MOD2=3,
//	MOD3=4,
// 	MOD4=5
// } staten;

//staten state,next;


parameter MODR=0;
parameter MOD0=1;
parameter MOD1=2;
parameter MOD2=3;
parameter MOD3=4;
parameter MOD4=5;
logic [2:0] state,next;


always_ff @(posedge clk) begin
	if(!resetn)
		state<=MODR;
	else
		state<=next;
end

always_comb begin
	case(state)
		MODR: next = din ? MOD1 : MOD0;
		MOD0: next = din ? MOD1 : MOD0;
		MOD1: next = din ? MOD3 : MOD2;
		MOD2: next = din ? MOD0 : MOD4;
		MOD3: next = din ? MOD2 : MOD1;
		MOD4: next = din ? MOD4 : MOD3;
	endcase
end

assign dout = state==MOD0;

endmodule
