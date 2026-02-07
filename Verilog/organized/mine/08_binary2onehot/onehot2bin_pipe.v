

// this is a pipelined version. 
// also the combinatorial logic is optimized with a casex. 
// that is more simple than sintax repetition with a for loop. 

// if the application is time critical, then try to keep it with just combinatorial logic
// to complete the operation in a single cycle. 
// if that is not possible, you can pipeline it to meet better the timing closure. 

module onehot2bin_pipe #(parameter W=4)(
	input wire clk,
	input wire rstn,
	input wire [(2**W)-1:0] in,
	output reg [W-1:0] out
);


reg [W-1:0] reg1;


always @ (*) begin

casex (in)
16'b1xxxxxxxxxxxxxxx: reg1=15;
16'b01xxxxxxxxxxxxxx: reg1=14;
16'b001xxxxxxxxxxxxx: reg1=13;
16'b0001xxxxxxxxxxxx: reg1=12;
16'b00001xxxxxxxxxxx: reg1=11;
16'b000001xxxxxxxxxx: reg1=10;
16'b0000001xxxxxxxxx: reg1=9;
16'b00000001xxxxxxxx: reg1=8;
16'b000000001xxxxxxx: reg1=7;
16'b0000000001xxxxxx: reg1=6;
16'b00000000001xxxxx: reg1=5;
16'b000000000001xxxx: reg1=4;
16'b0000000000001xxx: reg1=3;
16'b00000000000001xx: reg1=2;
16'b000000000000001x: reg1=1;
16'b0000000000000001: reg1=0;
default: reg1=0;
endcase


end

always @ (posedge clk) begin
	if (!rstn) begin
		out<=0;
	end else begin
		out<=reg1;
	end
end



endmodule
