

// this is a naive implementation. the first one that comes to mind maybe...

module model #(parameter CATCH=6)
(
	input  logic clk,
	input  logic resetn,
	input  logic validin,
	input  logic [31:0] din,
	output logic [7:0] dout,
	output logic validout
);

localparam WORD=CATCH/4;
localparam SHIFT=CATCH%4;


logic [7:0] c;


always_ff @(posedge clk) begin
	if( !resetn  ) begin
		c<=0;
		validout<=0;
		dout<=0;
	end else if (validin && c<WORD) begin
		c<=c+1;
		validout <= 0 ;
	end else if (validin && c==WORD) begin
		c<=0;
		dout <= din[ SHIFT*8 +:8 ];
		validout <= 1 ;
	end else begin
		validout<=0;
		dout<=0;
	end
end 
 

endmodule
