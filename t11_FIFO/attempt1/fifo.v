

// FIFO implementation


module fifo #(	parameter DATA_W=8,
				parameter L=10,
				parameter ADD_W=$clog2(L)
			)
(
	input wire clk,
	input wire rst,

	input wire wr_en,
	input wire rd_en,
	input wire [DATA_W-1:0] din,

	output reg [DATA_W-1:0] dout,
	output wire full,
	output wire empty
);

// memory, pointers for read write and counter. 
reg [DATA_W-1:0] mem [L-1:0];
reg [ADD_W-1:0] rd_ptr, wrt_ptr;
reg [ADD_W:0] count;


always @ (posedge clk or posedge rst) begin

	if (rst) begin
		count<=0;
		wrt_ptr<=0;
		rd_ptr<=0;
	end else begin

		//write fifo
		
		if (wr_en && !full) begin
			mem[wrt_ptr] <= din;
			wrt_ptr <= wrt_ptr+1;
			count <= count + 1;
			$display("din: ",din);
			//$display("writing mem[",wrt_ptr,"]: ",din," count: ",count," empty: ",empty," full: ",full);
		end

		//read fifo
		if (rd_en && !empty) begin
			dout<=mem[rd_ptr];
			rd_ptr<=rd_ptr+1;
			count <= count - 1;
			//$display("reading mem[",rd_ptr,"]: ",dout," count: ",count," empty: ",empty," full: ",full);
		end
	
	end


end

assign full = (count  == L) ;
assign	empty = (count==0);



endmodule


			
