
module model (
	input logic clk,
	input logic resetn,

	//left
	input  logic in_valid,
	input  logic [15:0] in_data,
	output logic in_ready, 

	//right
	output logic out_valid,
	output logic out_data,
	input  logic out_ready
);

logic grab_l, push_r;
logic go;
logic [$clog2(16):0] count;
logic [15:0] data;



always_ff @(posedge clk) begin
	if(!resetn) begin
		count<=0;
		go<=0;
	end else begin

		if(!go && grab_l) begin
			data<=in_data;
			go<=1;
			count<=0;
		end else if(go  && push_r && count<15) begin
			count<=count+1;
		end else if (go && push_r && count==15) begin
			count<=0;
			go<=0;
		end
		
	end
end



assign out_data  = go ? data[count] : 0;

assign in_ready  = ~go;
assign out_valid = go;

assign grab_l = in_valid && in_ready;
assign push_r = out_valid && out_ready;



endmodule
