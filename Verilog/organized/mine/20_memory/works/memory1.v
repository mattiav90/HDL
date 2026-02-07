
// OPTIMIZATIONS
// 
// *) no need to use the used memory struct. latency is important, remove
//    redundant complexity
// *) make reads combinatorial, or asynchronous. if I clk the reads, they
//    will be effective on the output one cycle after the read command.
//    I can make it combinatorial and save time.
//    some FPGA might not support the asynchronus read. 
// *) I can also consider to read and write in the same cycle. I need to 
//    use a dual port in this case. 
// *) consider that in FPGA, ou have BRAM. usually the BRAM are real memories
//    that are already implemented in the FPGAs. Usually they are synchronous
//    so if you write it in an asynchronous way, it will probably just use registers. 
//    if you want it to use the BRAM integrated, look at the documentation and write it 
//    in a way that the synthesis tool will recognize what you are trying to do.


// latency oriented version:



module memory1 #(
parameter L=10,
parameter W=8
)
(
input wire  				clk,
input wire  				resetn,
input wire  [$clog2(L):0] 	add,
input wire  [W-1:0] 	 	in,
input wire  				write_read,
output wire [W-1:0] 		out
);


reg [W-1:0] mem [0:L-1];


always @(posedge clk) begin
	if (write_read==1) begin
		mem[add]<=in;
	end
end


assign out = write_read==0 ? mem[add]:0;


endmodule
