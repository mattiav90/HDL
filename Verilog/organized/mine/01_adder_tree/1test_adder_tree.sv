
module test();

parameter W=32;
parameter N=8;

logic [W-1:0] in [N-1:0];
logic [W-1+$clog2(IN):0] sum, check;

adder_tree #(W,N) summa (in,sum);

initial begin
repeat (10) go;
$finish;
end


integer i;


task go;
begin
	check=0;
	for(i=0;i<N;i++) begin
		in[i]=$random;
		in[i]=in[i]%20;
		check=check+in[i];
	end

	#2;

	for(i=0;i<N;i++) begin
		$write(" in[%0d]: %0d ",i,in[i]);
	end

	if (sum==check) begin
		$display(" ..OK.. sum: %0d",sum);
	end else begin
		$display(" ..ERROR.. sum: %0d check: %0d",sum,check);
	end
	
end
endtask



endmodule

