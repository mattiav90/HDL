


module memory0 #(
parameter L=10,
parameter W=8
)
(
input wire  				clk,
input wire  				resetn,
input wire  [$clog2(L):0] 	add,
input wire  [W-1:0] 	 	in,
input wire  				write_read,
output wire [W-1:0] 		out
);

reg [W-1:0] mem [0:L-1];
integer i;
reg [W-1:0] out_reg;


always @(posedge clk) begin
	if (~resetn) begin
		for (i=0;i<L;i++) begin
			mem[i]<=0;
		end
	end else begin
		if(write_read) begin //write 
			mem[add]<=in;
		end else begin			//read
			out_reg<=mem[add];
		end
	end
end

assign out=out_reg;


endmodule
