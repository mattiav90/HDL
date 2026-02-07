
module model #(parameter CATCH=7)(
	input logic clk,
	input logic resetn,

	//left
	input logic validin,
	input logic [31:0] din,

	//right
	output logic [7:0] dout,
	output logic validout
);


localparam WORD  = CATCH/4;
localparam SHIFT = CATCH%4;

logic [$clog2(WORD):0] count;

always_ff @(posedge clk) begin
	if(!resetn) begin
		count<=0;
	end else begin

		if(validin && count<WORD) begin
			count<= count+1;
		end else if(validin && count==WORD) begin
			count<=0;
			dout<= din[8*SHIFT +:8]; 
			validout<=1;
		end else begin
			dout<=0;
			validout<=0;
		end 
		
	end
end


endmodule
