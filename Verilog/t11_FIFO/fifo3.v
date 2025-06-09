
// this implementation of the fifo will instantiate a dual port BRAM. 
// to allow read and write at the same time. 
// the previous implementations have the read and write logic in the same
// always block. that does not allow read and write in parallel. 

// the FIFO should be big enough (>512 bits total). small fifos might 
// still be implemented as LUTs. 

module fifo3 #(parameter L=8, W=8) (
	input wire clk, rstn,
	input wire w_en, r_en,
	input wire [W-1:0] data_in,
	output reg [W-1:0] data_out,
	output wire full, empty
);

parameter Wadd = $clog2(L);
(* ram_style= "block" *) reg [W-1:0] mem [0:L-1];	//specify that you want to use a BRAM
reg [Wadd:0] w_ptr, r_ptr;
wire wrap;


always @ (posedge clk) begin
	if (!rstn) begin
		w_ptr<=0;
		r_ptr<=0;
		data_out<=0;
	end
end


// write and read logic have to be separated from each other. 
// so they can be indipendend and run in parallel.

//write logic
always @ (posedge clk) begin
	if(w_en & !full) begin
		mem[w_ptr[Wadd-1:0]]<= data_in;
		w_ptr<=w_ptr+1;
	end
end


//write read and write logic separated so they can run in parallel.
//read logic
always @ (posedge clk) begin
	if(r_en & !empty) begin
		data_out<=mem[r_ptr[Wadd-1:0]];
		r_ptr<=r_ptr+1;
	end
end

assign empty = (w_ptr==r_ptr);
assign wrap = w_ptr[Wadd] ^ r_ptr[Wadd];
assign full = wrap & (w_ptr[Wadd-1:0]==r_ptr[Wadd-1:0]);

endmodule
