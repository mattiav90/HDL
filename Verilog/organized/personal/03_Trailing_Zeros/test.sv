

module test();

localparam BW=16;

logic [BW-1:0] din;
logic [$clog2(BW)-1:0] dout;


trailing #(BW) TR (din,dout);


initial begin

go(16'b1010101010101010);

go(16'b1010101010100000);

go(16'b1010101000000000);


$finish;
end


task go(logic [BW-1:0] data);
begin
	#10
	din=data;
	#20
	$display("%bdin: ",din," dout: ",dout);
	din=0;
end
endtask



initial begin
$dumpfile("wave.vcd");
$dumpvars;
end



endmodule
