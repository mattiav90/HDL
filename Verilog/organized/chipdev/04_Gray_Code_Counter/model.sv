
module model #(parameter DW=32)(
input logic clk,
input logic resetn,
output logic [DW-1:0] dout
);

logic [DW-1:0] temp;

always_ff @(posedge clk) begin
	if(~resetn) begin
		temp<=0;	
	end else begin
		temp<=temp+1;
	end
end

assign dout = temp ^ temp>>1;

endmodule
