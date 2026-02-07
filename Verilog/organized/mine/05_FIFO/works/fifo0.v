
// this fifo is the most naive version. 
// it has a counter that keeps truck of how many elements
// have been loaded in it. and is used as the pointer for writing

//there is extra logic that comes with the counter. 
//but is usefull in case you want to have almost full/empty signals.



module fifo1 #(
parameter W=8,
parameter L=8	
)(
input  wire clk,
input  wire resetn,
input  wire w_en,
input  wire r_en,
input  wire [W-1:0] data_in,
output reg [W-1:0] data_out,
output wire full,
output wire empty
);

reg [W-1:0] mem [0:L-1];
reg [$clog2(L):0] counter;
reg [$clog2(L)-1:0] w_ptr, r_ptr;

//writing
always @(posedge clk) begin
	if (!resetn) begin
		w_ptr<=0;
	end else begin
		if (w_en & !full) begin
			mem[w_ptr]<=data_in;
			w_ptr<=w_ptr+1;
		end
	end
end

//reading
always @(posedge clk) begin
	if (!resetn) begin
		r_ptr<=0;
	end else begin
		if (r_en & !empty) begin
			data_out<=mem[r_ptr];
			r_ptr<=r_ptr+1;
		end
	end
end

// counter
// be carefull to NOT encode priority in the way you write if else.
// if you write if else statements, they are evaluated in sequence
// and you might not reach the case you want if you dont write them 
// properly. sometimes is just better to write a CASE. it does not 
// assume any priority in options. 
always @(posedge clk) begin
	if (!resetn) begin
		counter<=0;
	end else begin
		case ({(w_en & !full),(r_en & !empty)})
			2'b01:   counter<=counter-1;
			2'b10:   counter<=counter+1;
			2'b11:   counter<=counter;
			default: counter<=counter;
		endcase
	end
end


assign full=  (counter==(L));
assign empty= (counter==0);



endmodule


