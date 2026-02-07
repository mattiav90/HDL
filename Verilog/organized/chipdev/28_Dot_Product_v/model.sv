
module model (
	input  logic clk,
	input  logic resetn,
	input  logic [7:0] din,
	output logic [17:0] dout,
	output logic run
);

logic [2:0] count;
logic [7:0] mem[0:5];
logic [17:0] temp;


//counter
always_ff @(posedge clk) begin
	if(!resetn || count==5)
		count<=0;
	else 
		count<=count+1;
end

//memory
always_ff @(posedge clk) begin
	if(!resetn) begin
		for(int i=0;i<6;i=i+1) begin
			mem[i]<=0;
		end
	end else begin
		mem[count]<=din;
	end
end


//result
always_comb begin
	if(count==0) begin
		temp=0;
		for(int i=0; i<3; i=i+1) begin
			temp=temp+mem[i]*mem[i+3];
		end
		dout=temp;
		run=1;
		
	end else begin
		run=0;
	end
end



endmodule
