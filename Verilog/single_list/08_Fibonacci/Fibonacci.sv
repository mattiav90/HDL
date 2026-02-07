
module Fibonacci (
	input  logic clk,
	input  logic reset,
	input  logic [7:0] din,
	output logic [31:0] out
);

logic [31:0] v1,v2,temp;
logic [7:0] n;


always_ff @(posedge clk) begin
	if(reset)
		n<=2;
	else
		n<=din;
end


always_comb begin

	if (n>2) begin
		v1=0; 
		v2=1; 
		for (int i=0; i<(n-1); i++) begin
			temp=v2;
			v2=v1+v2;
			v1=temp;
		end
		out = v2;

	// if n<=2
	end else begin
		out=0;
	end
	
end


endmodule
