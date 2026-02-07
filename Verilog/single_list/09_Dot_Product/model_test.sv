

module model (
	input  logic clk,
	input  logic resetn,
	input  logic [7:0] din,
	output logic [17:0] dout,
	output logic run
);

logic [$clog2(6):0] count;
logic [7:0] mem [0:5];
logic [17:0] temp;


always_ff @(posedge clk) begin
	if(!resetn) begin
		count<=0;
		mem[0]<=0;
		mem[1]<=0;
		mem[2]<=0;
		mem[3]<=0;
		mem[4]<=0;
		mem[5]<=0;
	end else begin
		count<= count==5 ? 0 : count+1;
		mem[count]<=din;
	end
end


always_comb begin

	if(count==0) begin
		temp=0;
		for(int i=0;i<3;i++) begin
			temp=temp+mem[i]*mem[i+3];
		end
		dout=temp;
	end
end

assign run=count==0;

endmodule
