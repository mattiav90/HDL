


module memory #(parameter W=8, L=10)(
	input wire clk,
	input wire reset,
	input wire wrt_read,
	input wire [W-1:0] write,
	input wire [$clog2(L)-1:0] add,
	input wire enable,
	output reg [W-1:0] out 
);

integer i;
reg [W-1:0] mem [L-1:0];

always @ (posedge clk ) begin

	if (reset) begin
		for(i=0;i<L;i=i+1) begin
			mem[i]<=0;
		end
	end else begin

	//write
	if(wrt_read) begin
		mem[add]<=write;

	//read
	end else begin
		out<=mem[add];
	end
	
		


	end
end


endmodule
