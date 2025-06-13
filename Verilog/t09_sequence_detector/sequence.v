


module sequence (
	input wire clk,
	input wire resetn,
	input wire din,
	output reg dout
);

reg  [3:0] data;
wire [3:0] newdata;


assign newdata = {data[2:0],din};

always @ (posedge clk) begin

if (!resetn) begin
	dout<=0;
	data<=0;
end else begin
data<=newdata;
dout<= (newdata==4'b1010);
$display("data: %b",data," dout: ",dout);
end

end



endmodule
