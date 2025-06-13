
`timescale 1ns/1ps;


module test();

parameter W=16;

reg 		    clk;
reg  [W-1:0] 	din;
reg  			resetn;
wire [W-1:0] 	dout;


fibonacci #(.W(W)) fb (
	.clk(clk),
	.din(din),
	.resetn(resetn),
	.dout(dout)
);



initial begin
clk=0;
forever #2 clk=!clk;
end


initial begin
$dumpfile("wave.vcd");
$dumpvars(0,test);

resetn=1;
#4
resetn=0;
#4
resetn=1;
#4


#4 $display("dout: ",dout);

#4 $display("dout: ",dout);

#4 $display("dout: ",dout);

#4 $display("dout: ",dout);


$finish;
end


endmodule
