

module model #(parameter DW=32) 
(
	input  logic clk,
	input  logic resetn,
	input  logic [DW-1:0] din,
	output logic [DW-1:0] dout	
);

logic [DW-1:0] max=0,max1=0;


always_ff @(posedge clk) begin
	if(~resetn) begin
		max<=0;
		max1<=0;	
	end else begin
		if(din>=max) begin
			max<=din;
			max1<=max;
		end else if(din>=max1 && din<max) begin
			max1<=din;
		end
	end
end

assign dout=max1;


endmodule
