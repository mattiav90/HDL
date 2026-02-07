
module model (
	input  logic clk,
	input  logic resetn,
	input  logic [7:0] din,
	input  logic [2:0] addr,
	input  logic wr,
	input  logic rd,
	output logic [7:0] dout,
	output logic error
);

logic [7:0] mem[0:7];

always_ff @(posedge clk) begin
	if(!resetn) begin

		for(int i=0; i<8; i=i+1) begin
			mem[i]<=0;
		end	
		error<=0;
		dout<=0;
		
	end else if (~wr && ~rd) begin
		error<=0;
		dout<=0;
	end else if (wr && ~rd) begin
		mem[addr]<=din;
		error<=0;
		dout<=0;
	end else if (~wr && rd) begin
		dout<=mem[addr];
		error<=0;
	end else begin
		error<=1;
		dout<=0;
	end		
end

endmodule
