

`timescale 1ns/1ps;


module test();

localparam w=32;

reg 				 clk;
reg [w-1:0]			 in;
reg 				 rst;
wire 				 val;
wire [$clog2(w)-1:0] out;


pe_32b pe32 (
	.in(in),
	.clk(clk),
	.rst(rst),
	.val(val),
	.out(out)	
);


initial begin
clk=0;
forever #2 clk=!clk;
end


initial begin 
$dumpfile("wave.vcd");
$dumpvars(0,test);


$monitor("monitor. time: %0t rst: %d in: %b out: %d",$time,rst,in,out);

rst=0;
#4
rst=1;
in=32'b00000000000000000000000000000001;
#4
in=32'b00000000000000000000000000000010;
#4
in=32'b00000000000000000000000000001000;
#4
in=32'b00000000000000000000000000010000;
#4
in=32'b00000000000000000000000000100000;
#4
in=32'b00000000000000000000000001000000;
#4
in=32'b00000000000000000000000010000000;
#4
in=32'b00000000000000000000000100000000;
#4
in=32'b00000000000000000000001000000000;
#4
in=32'b00000010010000010000001000000000;
#4
in=32'b00010001000000001000000100000000;
#4
in=32'b10000001000001000100000010000000;
#10

$finish;

end



endmodule
