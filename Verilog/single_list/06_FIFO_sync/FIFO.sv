

module FIFO #(
	parameter W=8,
	parameter L=8
)(
input  logic  clk,
input  logic  resetn,
input  logic  w_en,
input  logic  r_en,
input  logic  [W-1:0] data_in,
output logic  [W-1:0] data_out,
output logic  full,
output logic  empty
);

localparam Wadd = $clog2(L);
logic [W-1:0] mem [0:L-1];
logic [Wadd:0] w_ptr, r_ptr;
logic wrap;

//write logic
always_ff @(posedge clk) begin
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
always_ff @(posedge clk) begin
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
