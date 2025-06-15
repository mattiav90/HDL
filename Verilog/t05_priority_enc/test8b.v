
`timescale 1ns/1ps



module test;


parameter w_in  = 8;
parameter w_out = $clog2(w_in);


reg  [w_in-1:0] 			in;
wire [$clog2(w_in)-1:0] 	out;
wire 					val; 


pe_8b pe_8b_0 (
	.in(in),
	.val(val),
	.out(out)
);

initial begin 


in=8'b00000000;
#10
$display("in: %b val: %d out: %d ",in,val,out);



in=8'b00000100;
#10
$display("in: %b val: %d out: %d ",in,val,out);


in=8'b01000000;
#10
$display("in: %b val: %d out: %d ",in,val,out);




#10 $finish;
end



endmodule
