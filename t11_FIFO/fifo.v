

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
	output reg full,
	output reg empty
);

// memory, pointers for read write and counter. 
reg [DATA_W-1:0] mem [L-1:0];
reg [ADD_W-1:0] rd_ptr, wrt_ptr;
reg [ADD_W:0] count;


always @ (posedge clk or posedge rst) begin

	if (rst) begin
		full<=0;
		empty<=1;
		count<=0;
		wrt_ptr<=0;
		rd_ptr<=0;
	end else begin

		//write fifo

		if (wr_en & !full) begin
			mem[wrt_ptr] <= din;
			wrt_ptr <= wrt_ptr+1;
			count<=count+1;
			$display("writing mem[",wrt_ptr,"]: ",din);
		end

		//read fifo
		if (rd_en & !empty) begin
			dout<=mem[rd_ptr];
			rd_ptr<=rd_ptr+1;
			count<=count-1;
		end

		
		full <= (count==L-1) ? 1 : 0;
		empty <= (count==0);

	end


end




endmodule


			
