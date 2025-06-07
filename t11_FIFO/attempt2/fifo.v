

module fifo #( parameter WIDTH=8, LENGTH=10 )
(
input wire clk,
input wire rstn,
input wire w_en,
input wire r_en,
input wire [WIDTH-1:0] data_in,
output reg [WIDTH-1:0] data_out,
output wire full,
output wire empty
);


reg [WIDTH-1:0] mem [0:LENGTH-1];
reg [$clog2(WIDTH):0] counter, w_ptr, r_ptr;


//reset
always @ (posedge clk) begin
if (!rstn) begin
	data_out<=0;
	counter<=0;
	w_ptr<=0;
	r_ptr<=0;
end
end


//write
always @ (posedge clk) begin
if (w_en && !full) begin
mem[w_ptr] <= data_in;
w_ptr <= w_ptr+1;
counter <= counter+1;
end
end


always @ (posedge clk) begin
if (r_en && !empty) begin
data_out<=mem[r_ptr];
r_ptr<=r_ptr+1;
counter<=counter-1;
end
end


assign full= (counter==LENGTH);
assign empty = (counter==0);



endmodule

