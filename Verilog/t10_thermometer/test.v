

`timescale 1ns/1ps;



module test();

parameter W=8;

reg [W-1:0] din;
wire dout;


thermometer #(W) t (
	.din(din),
	.dout(dout)
);



initial begin

din=8'b0000000;
#10
$display("dout: ",dout);

din=8'b00000011;
#10
$display("dout: ",dout);

din=8'b00000000;
#10
$display("dout: ",dout);


$finish;

end




endmodule
