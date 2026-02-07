

//this is a variable shift register. 
//with select the variable shift can change. 

module my_dff #(parameter W=8)(
	input  wire clk,
	input  wire [W-1:0] d,
	output reg  [W-1:0] q
);
	always@(posedge clk) begin
	q<=d;
	end
endmodule 


module var_shift #(parameter W=8)(
	input   wire clk, 
	input   wire [W-1:0] d,
	input   wire [1:0] sel,
	output  reg  [W-1:0] q
);

wire [W-1:0] w1,w2,w3;


my_dff dff1(clk,d,w1);
my_dff dff2(clk,w1,w2);
my_dff dff3(clk,w2,w3);

always @(*) begin
	q=d;	//default assignment
	case(sel)
		1: q=w1;
		2: q=w2;
		3: q=w3;
	endcase
end

endmodule
