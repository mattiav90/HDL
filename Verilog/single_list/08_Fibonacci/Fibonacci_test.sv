
module Fibonacci (
	input  logic clk,
	input  logic reset,
	input  logic [7:0] din,
	output logic [31:0] out
);

logic [31:0] a,b,temp;

always_ff @(posedge clk) begin
	if(reset)
		out<=0;
	else 
		out<=b;
end


always_comb begin

	if(din==0) begin
		b=0;
	end else if (din==1 || din==2) begin
		b=1;
	end else begin
	
		a=1;
		b=1;
		for(int i=2;i<din; i++) begin
			temp=b;
			b=a+b;
			a=temp;
		end
		
	end

	
end



endmodule
