

module second_largest #(parameter WIDTH=8) (
	input wire clk,
	input wire resetn,
	input wire [WIDTH-1:0] din,
	output reg [WIDTH-1:0] dout	
);

reg [WIDTH-1:0] lar, sec;


always @ (posedge clk) begin
	if (!resetn) begin
		lar<=0;
		sec<=0;
		dout<=0;
	end else begin

		if (din>=lar) begin
			sec<=lar;
			lar<=din;
		end else if (din<lar && din>sec) begin
			sec<=din;
		end
	dout<=sec;
	end


end






endmodule
