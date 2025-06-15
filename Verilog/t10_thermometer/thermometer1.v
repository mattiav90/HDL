

module thermometer #(parameter W=8)(
	input wire [W-1:0] din,
	output wire dout
);

reg [W-1:0] temp;

integer i;

always @ (*) begin
	temp=0;
	for (i=0; i<W-1; i=i+1) begin
		temp[i]=din[i]^din[i+1];
	end

end

assign dout = (temp>0);



endmodule
