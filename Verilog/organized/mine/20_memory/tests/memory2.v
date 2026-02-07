
module memory2 #(
parameter L=8,
parameter W=8
)(
	input  wire clk,
	input  wire resetn,
	input  wire read_write,
	input  wire [$clog2(L):0] add,
	input  wire [W-1:0] in,
	output wire [W-1:0] out
);


reg [W-1:0] mem [0:L-1];
reg used [0:L-1];
integer i;
reg [W-1:0] out_reg;


always @(posedge clk) begin
	if (~resetn) begin
		for(i=0;i<L;i++) begin
			used[i]<=0;
		end
	end else begin

		if (read_write) begin
			used[add]<=1;
			mem[add]<=in;
		end else begin
			out_reg<=mem[add];
		end
	end
end

assign out=out_reg;

endmodule
