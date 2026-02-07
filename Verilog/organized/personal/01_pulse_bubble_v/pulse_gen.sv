
module pulse_gen(
	input clk, rst, valid,
	input [3:0] pulse_length,
	output pulse, ready
);


logic [3:0] data;
logic go;


always_ff @(posedge clk) begin

	if(rst) begin
		data<=0;
		go<=0;
	end else begin

		if(valid && ready) begin
			data <= pulse_length==0 ? 0 : pulse_length-1;
			go   <= pulse_length==0 ? 0 : 1;
		end 

		if(go) begin
			data <= data==0 ? 0 : data-1;
			go   <= data==0 ? 0 : go;
		end
		
	end

end


assign ready = !go;
assign pulse = go;

endmodule
