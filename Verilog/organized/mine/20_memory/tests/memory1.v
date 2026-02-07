

module memory1 #(
	parameter w=7,
	parameter l=10
	)
	(
		input  wire 		clk,
		input  wire 		reset,
		input  wire 		wrt_read,
		input  wire 		enable,
		input  wire [w:0]	write,
		input  wire [3:0] 	add,
		output wire [w:0]	out
	);


reg [w:0] mem [l:0];
reg [w:0] out_reg;

integer i;

assign out = out_reg;

always @ (posedge clk or posedge reset) begin

	if (reset) begin
		out_reg<=0;
		for (i=0; i<l; i=i+1) begin
			mem[i]<=0;
		end
	end
	else begin

	if (enable) begin
		if (wrt_read) begin
			mem[add]<= write;
			$display("write. mem[%d]<= %d",add,mem[add]);
		end else begin
			out_reg<=mem[add];
			$display("read. mem[%d]=> %d",add,mem[add]);
		end

	end


end



end




endmodule
	
