
module model #(parameter N=4)(
	input  logic clk,
	input  logic reset, 

	//left
	input  logic valid,
	input  logic [N-1:0] din,
	output logic ready,

	//right
	output logic pulse
);


logic go;
logic [N-1:0] data;

always_ff @(posedge clk) begin
	if(reset) begin
		go<=0;
		data<=0;
	end else begin

		if(!go && valid) begin
			data <= din==0 ? 0 : din-1;
			go   <= din==0 ? 0 : 1;
		end else if (go && data>0) begin
			data <= data-1;
		end else if (go && data==0) begin
			go <= 0;
		end
		
	end
end

assign pulse=go;
assign ready=~go;

endmodule
