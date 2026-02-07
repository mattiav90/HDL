

module FIFO_naive #(
	parameter W=8,
	parameter D=8
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


localparam addw = $clog2(D);


logic [W-1:0] mem [0:D-1];
logic [addw-1:0] w_add, r_add;
logic [addw:0] counter;


//write logic 
always_ff @(posedge clk) begin
	if(!resetn) begin
		w_add<=0;
	end else begin
		if (w_en && !full) begin
			mem[w_add]<=data_in;
			w_add<=w_add+1;
		end
	end
end


//read logic
always_ff @(posedge clk) begin
	if(!resetn) begin
		r_add <=0;
	end else begin
		if (r_en && !empty) begin
			data_out<=mem[r_add];
			r_add<=r_add+1;
		end
	end
end



//counter logic
always_ff @(posedge clk) begin
	if(!resetn) begin
		counter<=0;
	end else begin
		case ( { (w_en && !full) , (r_en && !empty) } )
			2'b10: counter<=counter+1;
			2'b01: counter<=counter-1;
			default: counter<=counter;
		endcase
	end
end




//full and empty
assign full  = counter==D;
assign empty = counter==0;





endmodule
