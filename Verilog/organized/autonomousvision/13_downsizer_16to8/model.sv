

module in32_out1 (
	input  logic clk,
	input  logic rst,
	input  logic [31:0] din,
	input  logic valid,
	output logic out,
	output logic ready
);

logic [$clog2(32):0] count;
logic [31:0] data;


always_ff @(posedge clk) begin
	if(rst) begin
		out<=0;
		count<=0;
		dout<=0;
	end else if(valid && ready) begin
		data<=din;
		count<=32;
	end else if(count>0) begin
		data<=data>>1;
		out<=data[0];
		count<=count-1;
	end	else begin
		dout<=0;
	end
end


assign ready = count==0;

endmodule
