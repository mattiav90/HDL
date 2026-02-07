
module fifo_ok #(parameter N=8, D=16)(
	input  logic clk,
	input  logic rst,
	input  logic wr,
	input  logic rd,
	input  logic [N-1:0] din,
	output logic [N-1:0] dout,
	output logic full,
	output logic empty
);

localparam Dbw = $clog2(D);

logic [N-1:0] mem[0:D-1];
logic [Dbw:0] wptr, rptr;


//write
always_ff @(posedge clk) begin
	if(rst) begin
		wptr<=0;
	end else begin
		mem[wptr[Dbw-1:0]] <= din;
      	wptr <= wptr + 1;
	end
end


// read
always_ff @(posedge clk) begin
	if(rst) begin
		rptr<=0;
	end else begin
	    dout <= mem[rptr[Dbw-1:0]];
	    rptr <= rptr + 1;
	end
end


assign empty = wptr == rptr;
assign full  = { !wptr[Dbw] , wptr[Dbw-1:0] } == rptr;

endmodule
