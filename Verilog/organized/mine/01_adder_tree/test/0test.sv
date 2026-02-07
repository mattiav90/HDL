
`timescale 1ns/1ps;


module test();

parameter W=4;
parameter IN=16;

logic [W-1:0] in[0:IN-1];
logic [W-1+IN:0] sum,temp;

adder_naive #(IN,W) dut (in,sum);


task go;
	integer i;
	begin
		$display("test. ");
		
		temp=0;
		for (i=0; i<IN; i++) begin
			in[i]=$random;
			$write(" %d ",in[i]);
			temp=temp+in[i];
		end

		#5;

		if(temp==sum) begin
			$display("OK. sum: %d ",sum);
		end else begin
			$display("error. temp: %d sum: %d ",temp,sum);
		end
	end
endtask



initial begin
repeat (10) go;
$finish;
end



initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
end


endmodule
