

module test;

parameter W=8;

reg [W-1:0] din;
wire [W-1:0] dout;

reverse #(W) rev (din,dout);


initial begin

din=8'b10100100;
#6;
$display("din: %b dout: %b",din,dout);

din=8'b11110000;
#6;
$display("din: %b dout: %b",din,dout);

din=8'b10100100;
#6;
$display("din: %b dout: %b",din,dout);


$finish;
end




initial begin
$dumpfile("wave.vcd"); $dumpvars;
end



endmodule
