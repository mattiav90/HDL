

`timescale 1ns/1ps



module test;

localparam w=7;
localparam l=10;

reg 		clk;
reg 		reset;
reg 		wrt_read;
reg [w-1:0] 	write;
reg [3:0] 	add;
reg 		enable;
wire [w-1:0] 	out;


initial begin 
clk=0;
forever #2 clk = !clk;
end

// ice of memory
memory #( .W(w),
		  .L(l))
	mem0 (
	.clk(clk),
	.reset(reset),
	.wrt_read(wrt_read),
	.write(write),
	.add(add),
	.enable(enable),
	.out(out)
);

integer dl=5;

// test procedure 
initial begin 

$dumpfile("wave.vcd");
$dumpvars(0,test);


//initialize 
reset=1;
write=0;
add=0;
enable=0;
wrt_read=0;
#dl
$display("After reset asserted - out: %d", out);

reset=0;
enable=1;
wrt_read=1;

// write 10 in add=0
write=10;
add=0;
#dl

//write 33 in add=3
write=33;
add=3;
#dl


//write 66 in add=5
write=66;
add=5;
#dl

// read from add 0
wrt_read=0;
add=0;
#dl 
$display("0) out: %d",out);

//read from add 1
add=1;
#dl
$display("1) out: %d",out);

//read from add 3
add=3;
#dl
$display("3) out: %d",out);






#10 
$finish;
end






endmodule
