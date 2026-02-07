
module model (
input logic clk,
input logic resetn,
input logic din,
output logic dout
);

logic r,r1;

always_ff @(posedge clk) begin
	if(~resetn) begin
		r<=0;
		r1<=0;
	end else begin
		r<=din;
		r1<=din & ~r;
	end 
end

assign dout = r1;

endmodule
