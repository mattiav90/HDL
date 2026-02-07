
module dv3 (
	input  logic clk, 
	input  logic rst,
	input  logic din,
	output logic divisible
);

parameter MODR=0;
parameter MOD0=1;
parameter MOD1=2;
parameter MOD2=3;

logic [1:0] state,next;


always_ff @(posedge clk) begin
	if(rst) 
		state<=MODR;
	else
		state<=next;
end


always_comb begin
next=MODR;
case (state)
	MODR: next = din ? MOD1 : MOD0;
	MOD0: next = din ? MOD1 : MOD0;
	MOD1: next = din ? MOD0 : MOD2;
	MOD2: next = din ? MOD2 : MOD1;
endcase
end


assign divisible = state==MOD0;


endmodule
