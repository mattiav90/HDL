
module pulse_sync (
	input logic clk_a,			// clock domain a
	input logic clk_b,			// clock domain b
	input logic arstn,			// asynchronous reset, active low
	input logic pls_a,			// pulse from clk a
	output logic pls_b			// pulse into clk b
);

logic ffa,ffb,ffc,ffd;

// clock domain A 
always_ff @(posedge clk_a or negedge arstn) begin
	if(!arstn) begin
		ffa<=0;
	end else begin
		ffa <= pls_a ? ~ffa : ffa; 	
	end
end


//clock domain B

always_ff @(posedge clk_b or negedge arstn) begin
	if(!arstn) begin
		ffb<=0;
		ffc<=0;
	end else begin
		ffb<=ffa;
		ffc<=ffb;
	end
end

always_ff @(posedge clk_b or negedge arstn) begin
	if(!arstn) begin
		ffd<=0;
	end else begin
		ffd<=ffc;
	end
end

assign pls_b = ffd ^ ffc;


endmodule
