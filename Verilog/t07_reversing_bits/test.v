

`timescale 1ns/1ps;


module test();

parameter W=16;

reg  [W-1:0] din;
wire [W-1:0] dout;

reverse_bits #(W) rb(
	.din(din),
	.dout(dout)	
);


initial begin 
$dumpfile("wave.vcd");
$dumpvars(0,test);


din = 16'b1000000001111000;
#10
$display("din: %b dout: %b",din,dout);

din = 16'b1111000000000000;
#10
$display("din: %b dout: %b",din,dout);

din = 16'b1000000000000111;
#10
$display("din: %b dout: %b",din,dout);




$finish;
end



endmodule
