

module test();

parameter W=16;
parameter STAGES=$clog2(W)+1;

logic [W-1:0] in;
logic [$clog2(W):0] count;
logic clk;
logic [$clog2(W):0] temp [0:STAGES];

integer write,read;


pop_count_tree_pipe #(W) dut (clk,in,count);


initial begin
clk=0;
forever #2 clk=~clk;
end



task go;
integer i;
begin

	@(negedge clk);
	in=$random;
	temp[write]=0;
	for (i=0;i<W;i++)  begin
	 temp[write] = temp[write]+in[i];
	end

	@(posedge clk);
	if (temp[read]==count) begin
	$display("OK. in: %b count: %d ",in,count);
	end else begin
	$display("ERROR. in: %b count: %d check: %d",in,count,temp[read]);
	end

	write=write+1;
	read=read+1;
	write = write==STAGES+1 ? 0 : write;
	read = read==STAGES+1 ? 0 : read;

end
endtask


initial begin
write=STAGES;
read=0;

repeat (20) go;
$finish;
end



initial begin
$dumpfile("wave.vcd");
$dumpvars;

end




endmodule
