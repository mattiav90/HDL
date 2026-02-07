
`timescale 1ns/1ps;


module test();

parameter W=4;
parameter IN=4;
parameter STAGES = $clog2(IN);

logic [W-1:0] in[0:IN-1];
logic [W-1+$clog2(IN):0] sum;
logic [W-1+$clog2(IN):0] temp [0:STAGES+1];
logic clk;

logic [5:0] write;
logic [5:0] read;


adder_tree_pipe #(IN,W) dut (clk,in,sum);


initial begin
clk=0;
forever #2 clk=~clk;
end



task go;
	integer i;
	begin
		$display("test. ");
		@(negedge clk);
		temp[write]=0;
		for (i=0; i<IN; i++) begin
			in[i]=$random;
			$write(" %d ",in[i]);
			temp[write]=temp[write]+in[i];
		end

		@(posedge clk);
		if(temp[read]==sum) begin
			$display("OK. sum: %d ",sum);
		end else begin
			$display("error. temp: %d sum: %d ",temp[read],sum);
		end

		write=write+1;
		read=read+1;
		write= write==STAGES+2 ? 0 : write;
		read=  read==STAGES+2  ? 0 : read;
	end
endtask



initial begin
write=STAGES+1;
read=0;
repeat (20) go;
$finish;
end



initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
end


endmodule
