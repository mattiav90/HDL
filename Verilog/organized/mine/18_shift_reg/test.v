
`timescale 1ns/1ps;


module test();

parameter W=8;
parameter D=8;


reg clk;
reg rst;
reg [W-1:0] din;
wire [W-1:0] dout;


shift_reg_opt #(W,D) ss (clk,rst,din,dout);


initial begin
clk=0;
forever #2 clk=!clk;
end




initial begin
rst=0;
din=0;
#10;
rst=1;
#10;
end


always @ (negedge clk) begin
 if (rst) begin
	din<=$random;
 end
end


always @ (posedge clk) begin
 $display("Time: %t | din = %d | dout = %d", $time, din, dout);
end


initial begin
#100;
$finish;
end


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end




endmodule
