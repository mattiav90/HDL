


module model #(parameter CATCH=6)
(
	input  logic clk,
	input  logic resetn,
	input  logic validin,
	input  logic [31:0] din,
	output logic [7:0] dout,
	output logic validout
);


localparam WORD= CATCH/4;
localparam SHIFT=CATCH%4;


logic [8:0] count;

always_ff @(posedge clk) begin
	if(reset) begin
		count<=0;
		dout<=0;
		validout<=0;
	end else begin

		if(count<WORD) begin
			count<=count+1;
			validout<=0;
			dount<=0;
		end else if (count==WORD) begin
			count<=0;
			validout<=1;
			dout<= din[SHIFT*8 +: 8];
		end else 
			validout<=0;
			dout<=0;
		end
	
	end
end



endmodule 
