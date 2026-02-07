

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
$display("din: %b dout: ",din,dout);

din=8'b00000011;
#10
$display("din: %b dout: ",din,dout);

din=8'b00000000;
#10
$display("din: %b dout: ",din,dout);

din=8'b01010000;
#10
$display("din: %b dout: ",din,dout);

din=8'b00010000;
#10
$display("din: %b dout: ",din,dout);

din=8'b00000100;
#10
$display("din: %b dout: ",din,dout);


$finish;

end




endmodule
