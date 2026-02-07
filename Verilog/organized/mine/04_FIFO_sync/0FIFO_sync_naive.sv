
// this fifo is the most naive version. 
// it has a counter that keeps truck of how many elements
// have been loaded in it. and is used as the pointer for writing

//there is extra logic that comes with the counter. 
//but is usefull in case you want to have almost full/empty signals.



module fifo1 #(
parameter W=8,
parameter L=8	
)(
input  logic clk,
input  logic resetn,
input  logic w_en,
input  logic r_en,
input  logic [W-1:0] data_in,
output logic [W-1:0] data_out,
output logic full,
output logic empty
);

logic [W-1:0] mem [0:L-1];
logic [$clog2(L):0] counter;
logic [$clog2(L)-1:0] w_ptr, r_ptr;

//writing
always_ff @(posedge clk) begin
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
always_ff @(posedge clk) begin
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
always_ff @(posedge clk) begin
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


