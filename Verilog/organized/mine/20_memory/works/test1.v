
`timescale 1ns/1ps


module test2();

parameter L=8;
parameter W=8;


reg clk;
reg resetn;
reg [$clog2(L):0] add;
reg [W-1:0] in;
wire [W-1:0] out;
reg write_read;

memory1 #(.L(L),.W(W)) mem (clk,resetn,add,in,write_read,out);



integer i;

initial begin
clk=0;
forever #5 clk=~clk;
end


initial begin
//initialize-reset
#10
resetn=0;
add=0;
in=0;
write_read=0;
#10
resetn=1;


//write
for (i=0;i<L;i=i+1) begin
	@(negedge clk);
	add=i;
	in=i;
	write_read=1;
end

//wait
@(posedge clk);
#1

//read
for (i=0;i<L;i=i+1) begin
@(negedge clk);
add=i;
write_read=0;
@(posedge clk);	// the only line that change is this one. 
				// I dont have to wait a full cycle to read 
				// the output in this case. 
$display("READ: mem[%d] = %d ",add,out);

end


$finish;
end



initial begin
$dumpfile("wave.vcd");
$dumpvars;
end





endmodule
