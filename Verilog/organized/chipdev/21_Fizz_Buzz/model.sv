

module model #(
parameter 
FIZZ=3,
BUZZ=4,
MAX=30
)(
	input  logic clk,
	input  logic resetn,
	output logic fizz,
	output logic buzz,
	output logic fizzbuzz 
);

logic [$clog2(MAX):0] c;

always_ff @(posedge clk) begin
	if(!resetn)
		c<=0; 
	else
		c<=c+1;
end

assign fizz= c%FIZZ==0;
assign buzz = c%BUZZ==0;
assign fizzbuzz = fizz && buzz;


endmodule
