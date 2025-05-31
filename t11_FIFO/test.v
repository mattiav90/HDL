

`timescale 1ns/1ps;



module test();

parameter DATA_W=8;
parameter L=3;
parameter ADD_W=$clog2(L);

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [DATA_W-1:0] din;

wire [DATA_W-1:0] dout;
wire full;
wire empty;


fifo #(	.DATA_W(DATA_W),
		.L(L)
	) fifo0 	
(
	.clk(clk),
	.rst(rst),
	.wr_en(wr_en),
	.rd_en(rd_en),
	.din(din),
	.dout(dout),
	.full(full),
	.empty(empty)
);


initial begin
clk=0;
forever #2 clk=!clk;
end



initial begin
$dumpfile("wave.vcd");
$dumpvars(0,test);

$monitor("dout: %d",dout," full: ",full," empty: ",empty);
rst=1;  #10;
rst=0;  

din=3; 
#1;
wr_en=1;

//write in a bunch of files. 

din=4; #4;
din=5; #4;
din=6; #4;
din=7; #4;
din=8; #4;
din=9; #4;
din=10; #4;


//read out a bunch of files. 

wr_en=0;
rd_en=1;




#100;
$finish;
end


endmodule
