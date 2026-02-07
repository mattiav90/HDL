
module shift_reg_opt 
#(parameter W=8, parameter D=8)(
	input wire clk,
	input wire rst,
	input wire [W-1:0] din,
	output wire [W-1:0] dout
);


reg [W-1:0]         regn [0:D-1];
reg [$clog2(D)-1:0] ptr;
integer i;


//this code will write in the ptr spot, but at the next clk edge
always @ (posedge clk or negedge rst) begin
	if (!rst) begin
		ptr<=0;
	end else begin

		regn[ptr]<=din;
		ptr<=ptr+1;
	end
end

//here I read from ptr spot. but I get the current content. 
//which is still undefined. 
assign dout= regn[ptr];

// so I basically end up having also here a delay of D clk in the
// output but I do not have to shift the values actially. 



endmodule
