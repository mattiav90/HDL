
module fifo #(parameter N=8, D=16)(
	input  logic clk,
	input  logic rst,
	input  logic wr,
	input  logic rd,
	input  logic [N-1:0] din,
	output logic [N-1:0] dout,
	output logic full,
	output logic empty
);


localparam BW = $clog2(D);

logic [N-1:0] mem [0:D-1];
logic [BW:0] wptr, rptr;


//write
always_ff @(posedge clk) begin
	if (rst) begin
		wptr<=0;
	end else if(wr && !full) begin
		mem[wptr[BW-1:0]]<=din;
		wptr<=wptr+1;
	end
end


//read
always_ff @(posedge clk) begin
	if (rst) begin
		rptr<=0;
		dout<=0;
	end else if(rd && !empty) begin
		dout<=mem[rptr[BW-1:0]];
		rptr<=rptr+1;
	end
end


assign empty = wptr==rptr; 
assign full  = {!wptr[BW] , wptr[BW-1:0] } == rptr;


endmodule
