


module jk (
		input wire clk,
		input wire rst,
		input wire j,
		input wire k,
		output reg q
);

	always @ (posedge clk or negedge rst) begin

	if (!rst) begin
		q<=0;
	end else
	
		case ({j,k})
		2'b10:   q<=1;
		2'b01:   q<=0;
		2'b11: 	 q<=!q;
		default: q<=q;
		endcase	
			
	end
	
endmodule
