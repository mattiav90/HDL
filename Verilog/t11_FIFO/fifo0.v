
//fifo0 has exatcly the number of bits that are needed
//it wraps around. it finds empty and full with pointers.
// super simple, no counter needed. works well.

module fifo0 #(parameter W=8, L=8)(

input wire clk, rstn,
input wire w_en, r_en,
input wire [W-1:0] data_in,
output reg [W-1:0] data_out,
output wire full, empty
);


reg [W-1:0] mem [0:L-1];
reg [$clog2(L)-1:0] w_ptr, r_ptr;



always @ (posedge clk) begin
if (!rstn) begin
	w_ptr<=0;
	r_ptr<=0;
	data_out<=0;
end
	//write
	if(w_en & !full) begin
		mem[w_ptr]<=data_in;
		w_ptr<=w_ptr+1;
	end
	
	//read
	if(r_en & !empty) begin
		data_out<=mem[r_ptr];
		r_ptr<=r_ptr+1;
	end
end

assign empty = (w_ptr==r_ptr);
assign full = (w_ptr+1==r_ptr);


endmodule
