

module fifo0 #(
	parameter W=8,
	parameter L=8
)(
input wire  clk,
input wire  resetn,
input wire  w_en,
input wire  r_en,
input wire  [W-1:0] data_in,
output reg  [W-1:0] data_out,
output wire full,
output wire empty
);

parameter Wadd = $clog2(L);
reg [W-1:0] mem [0:L-1];
reg [Wadd:0] w_ptr, r_ptr;
wire wrap;

//write logic
always @(posedge clk) begin
	if (!resetn) begin
		w_ptr<=0;
	end else begin
		if (w_en && !full) begin
			mem[w_ptr[Wadd-1:0]]<=data_in;
			w_ptr<=w_ptr+1;
		end
	end
end 


//read logic
always @(posedge clk) begin
	if(!resetn) begin
		r_ptr<=0;
		data_out<=0;
	end else begin
		if (r_en && !empty) begin
			data_out<=mem[r_ptr[Wadd-1:0]];
			r_ptr<=r_ptr+1;
		end
	end
end



assign wrap  = w_ptr[Wadd]^r_ptr[Wadd];
assign empty =  w_ptr==r_ptr;
assign full  = wrap && (w_ptr[Wadd-1:0]==r_ptr[Wadd-1:0]);



endmodule
