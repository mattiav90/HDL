
`timescale 1ns/1ps;


module test();


parameter W=32;

logic [W-1:0] in;
logic [$clog2(W)-1:0] shift;
logic [W-1:0] out, check;

naive #(W) bs (in,shift,out);


initial begin
repeat (10) go;
$finish;
end

task go;
begin
	in=$random;
	shift=$random;

	check = in<<shift;

	#2;

	if (out==check) begin
		$display("ok. in: %b shift: %d out:%b",in,shift,out);
	end else begin	
		$display("error. in: %b shift: %d out:%b check: %b",in,shift,out,check);
	end
	
end
endtask



initial begin
$dumpfile("wave.vcd");
$dumpvars;
end


endmodule
