

module reverse_bits #(parameter WIDTH=16)
					(
						input  wire [WIDTH-1:0] din,
						output wire [WIDTH-1:0] dout
					);

reg [WIDTH-1:0] temp;

integer i;

always @ (*) begin
	for (i=0; i<WIDTH; i=i+1) begin
		temp[i] = din[(WIDTH-1)-i];			
	end
end

assign dout = temp;

endmodule 
