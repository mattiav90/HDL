

module model (
	input  logic clk, 
	input  logic resetn,
	input  logic din,
	output logic dout
);

parameter MODR=0;
parameter MOD0=1;
parameter MOD1=2;
parameter MOD2=3;
parameter MOD3=4;

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
		MOD1: next = din ? MOD0 : MOD2;
		MOD2: next = din ? MOD2 : MOD1;
	endcase
end

assign dout = state==MOD0;


endmodule
