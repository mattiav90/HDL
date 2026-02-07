
`timescale 1ns/1ps


module test();


parameter W=32;

logic [W-1:0] in;
logic [$clog2(W)-1:0] idx;
logic val;


naive #(W) pe (in,idx,val);


task go;
begin
in=$random;
#2;
$display("in: %b idx: %d valid: %d",in,idx,val);
end
endtask

initial begin
repeat (20) go;
$finish;
end


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end




endmodule
