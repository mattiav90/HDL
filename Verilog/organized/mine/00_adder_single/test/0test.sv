
`timescale 1ns/1ps;


module test();

parameter W=32;
logic [W-1:0] a,b,sum, temp;

adder0 #(W) dut (a,b,sum);


task go;
	begin
	a=$random;
	b=$random;
	temp = a+b;
	#5;

	if (sum==temp)
	$display("OK. a: %d  b: %d out: %d ",a,b,sum);
	else 
	$display("ERROR. a: %d  b: %d out: %d ",a,b,sum);
	end
endtask


initial begin
repeat (10) go;
end


initial begin
$dumpfile("wave.vcd");
$dumpvars;
end

endmodule
