

module model (
	input  logic clk,
	input  logic resetn,
	output logic div2,
	output logic div4,
	output logic div6 
);


logic c4;
logic [1:0] c6;


always_ff @(posedge clk) begin
	if(!resetn) begin
		div2<=0;
		div4<=0;
		div6<=0;
		c4<=0;
		c6<=0;
	end else begin

		//2
		div2<=~div2;

		//4
		c4<= c4==1 ? 0 : c4+1;
		div4<= c4==0 ? ~div4 : div4;

		//6
		c6<= c6==2 ? 0 : c6+1;
		div6<= c6==0 ? ~div6 : div6;
		
	end
end




endmodule
