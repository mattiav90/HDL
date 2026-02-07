

module model (
	input logic clk,
	input logic reset,
	input logic valid,
	input logic [3:0] din,
	
	//output left
	output logic ready,
	//output right
	output logic pulse
);


logic [3:0] count;
logic go;

always_ff @(posedge clk) begin
	if(reset) begin
		count<=0;
		go<=0;
	end else begin

		if(!go && valid) begin
			count<= din==0 ? 0 : din-1;
			go   <= din==0 ? 0 : 1;
		end else if (go && valid) begin
			count <= din==0 ? count-1 : count+din-1;
		end else if (go && count>0 ) begin
			count <= count-1;
		end else if (go && count==0) begin
			go <=0;
		end
	end
end

assign pulse=go;
assign ready=!go;


endmodule
