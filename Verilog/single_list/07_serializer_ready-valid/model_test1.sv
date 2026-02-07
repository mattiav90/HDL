

module model #(parameter N=16)(
	input  logic clk,
	input  logic resetn,

	//left
	input  logic in_valid,
	input  logic [N-1:0] in_data,
	output logic in_ready,

	//right
	output logic out_valid,
	input  logic out_ready,
	output logic out_data  
);


logic [N-1:0] data;
logic [$clog2(N):0] count;
logic go;

logic grab_l, push_r;



always_ff @(posedge clk) begin
	if(!resetn) begin
		go<=0;
		count<=0;
	end else begin

		if(!go && grab_l) begin
			data<=in_data;
			go<=1;
		end else if (go && push_r && count<N-1) begin
			count<=count+1;
		end else if (go && push_r && count==N-1) begin
			count<=0;
			go<=0;
		end
	end
end


assign out_data = go ? data[count] : 0;

assign in_ready = ~go;
assign out_valid = go;

assign grab_l = in_ready && in_valid;
assign push_r = out_ready && out_valid;

endmodule
