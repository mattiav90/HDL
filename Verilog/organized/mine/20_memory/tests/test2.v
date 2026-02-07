

`timescale 1ns/1ps


module test();


parameter W=10;
parameter L=10;



reg  clk;
reg  resetn;
reg  [$clog2(L):0] add;
reg  [W-1:0] in;
wire [W-1:0] out;
reg  read_write;
integer i;

memory2 #(L,W) mem (clk,resetn,read_write,add,in,out);


initial begin
clk=0;
forever #5 clk=~clk;
end


initial begin

//reset and initialize
resetn=0;
add=0;
in=0;

//start sim
resetn=1;

//write
read_write=1;
for(i=0;i<L;i++)begin
	@(negedge clk);
	add=i;
	in=i*2;
end


//wait a sec
@(negedge clk);

//read
read_write=0;
for(i=0;i<L;i++)begin
	@(negedge clk);
	add=i;
	@(negedge clk);
	$display("READ: mem[%d] = %d",add,out);
end



$finish;

end



initial begin
$dumpfile("wave.vcd");
$dumpvars;
end


endmodule
