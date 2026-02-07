

`timescale 1ns/1ps;


module test();


localparam W=32;
logic [W-1:0] a,b;
logic [W-1:0] sum, check;


naive #(W) nsum (a,b,sum);


initial begin

repeat (10) go;
$finish;
end



task go;
begin
a=$random;
b=$random;
check = a+b;
#1;

if (check!=sum) begin
$display("ERROR. %d + %d = %d ",a,b,sum);
end else begin
$display("OK. %d + %d = %d ",a,b,sum);
end
end
endtask


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end







endmodule
