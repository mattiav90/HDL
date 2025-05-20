
module tb;

reg j;
reg k;
reg clk;
wire q;


jk jk0(
	.j(j),
	.k(k),
	.clk(clk),
	.q(q)
);

initial begin 
	clk=0;
	forever #1 clk=~clk;
end 


initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0,tb);

	#5 
	j<=0;
	k<=1;
	$display("time: %d j: %d k: %d q: %d",$time,j,k,q);

	#10
	j<=1;
	k<=0;
	$display("time: %d j: %d k: %d q: %d",$time,j,k,q);

	#10
	j<=1;
	k<=1;
	$display("time: %d j: %d k: %d q: %d",$time,j,k,q);

	#10
	j<=0;
	k<=0;
	$display("time: %d j: %d k: %d q: %d",$time,j,k,q);


	#10
	$finish;

end


endmodule 
