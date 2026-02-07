
// this implementation uses 1 extra bit for the pointers, to 
// recognize the wrap around.


module fifo1 #(parameter W=8, L=8)(
	input wire clk, rstn,
	input wire w_en,r_en,
	input wire [W-1:0] data_in,
	output reg [W-1:0] data_out,
	output wire full , empty
);

parameter WPTR=$clog2(L);
reg [W-1:0] mem [L-1:0];
//notice that here I use one extra bit then necessary
reg [WPTR:0] w_ptr , r_ptr;
wire wrap;

always @ (posedge clk) begin

if (!rstn) begin
data_out<=0;
w_ptr<=0;
r_ptr<=0;
end

if(w_en & !full) begin
mem[w_ptr[WPTR-1:0]]<=data_in;
w_ptr<=w_ptr+1;
end

if(r_en & !empty) begin
data_out<=mem[r_ptr[WPTR-1:0]];
r_ptr<=r_ptr+1;
end

end


assign empty = (w_ptr==r_ptr);

assign wrap = w_ptr[WPTR] ^ r_ptr[WPTR];
assign full = wrap & ( w_ptr[WPTR-1:0] == r_ptr[WPTR-1:0]);

endmodule
