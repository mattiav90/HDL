
module FIFO #(parameter W=8,L=8)(
	input  logic clk,
	input  logic resetn,

	//left
	input  logic w_en,
	input  logic [W-1:0] data_in,
	output logic full,

	//right
	input  logic r_en,
	output logic [W-1:0] data_out,
	output logic empty 
);

localparam PW=$clog2(L);

// one extra bit for wrap around
logic [PW:0] w_ptr,r_ptr;
logic [W-1:0] mem [0:L-1];

always_ff @(posedge clk) begin
	if(!resetn) begin
		w_ptr<=0;
		r_ptr<=0;
	end else begin

		if(!full && w_en) begin
			mem[w_ptr[PW-1:0]]<=data_in;
			w_ptr<=w_ptr+1;
		end

		if(!empty && r_en) begin
			data_out<=mem[r_ptr[PW-1:0]];
			r_ptr<=r_ptr+1;
		end
	end
end

assign full  = {~w_ptr[PW],w_ptr[PW-1:0]} == r_ptr;
assign empty = w_ptr==r_ptr;

endmodule
