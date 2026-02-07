
module test();

logic clk,rst,din,divisible;

dv3 dut (
.clk(clk),
.rst(rst),
.din(din),
.divisible(divisible)
);


initial begin
clk=0;
forever #5 clk=~clk;
end



initial begin

//reset
rst=1;
din=0;
repeat(3) @(posedge clk);
rst=0;
repeat(3) @(posedge clk);


//bit stream
send_bit(1);
send_bit(0);
send_bit(0);
send_bit(1);
send_bit(0);
send_bit(1);


repeat(5) @(posedge clk);
$finish;

end


task send_bit(input logic b);
begin
	@(posedge clk);
	din = b;
end
endtask


//monitor
initial begin
$display(" time | din | divisible");
$monitor(" %4t  |  %b  |    %b ",$time,din,divisible);
end


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end

endmodule
