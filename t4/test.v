

`timescale 1ns/1ps



module test;

localparam w=7;

reg 		clk;
reg 		reset;
reg [w:0] 	write;
reg [3:0] 	add;
reg 		enable;
wire [w:0] 	out;


initial begin 
clk=0;
forever #5 clk = !clk;
end

// instance of memory
memory mem0 (
	.clk(clk),
	.reset(reset),
	.write(write),
	.add(add),
	.enable(enable),
	.out(out)
);


// test procedure 
initial begin 

reset=1;
write=0;
add=0;
enable=0;


#5 reset=0;
write=3;
add=0;
enable=1;


#5 reset=0;
write=6;
add=5;
enable=1;




#10 $finish;
end






endmodule
