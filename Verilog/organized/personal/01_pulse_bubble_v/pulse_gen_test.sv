


// pulse gen

module pulse_gen(
	input clk, rst, valid,
	input [3:0] pulse_length,
	output pulse, ready
);


logic [3:0] length;
logic go;

always_ff @(posedge clk) begin
	if(rst) begin
		length<=0;
		go<=0;
	end else if(valid && !go) begin
		length<=pulse_length==0 ? 0 : pulse_length-1;
		go <= pulse_length==0 ? 0 : 1;
	end else if (go) begin
		length<= length==0 ? 0 : length-1;
		go <= length==0 ? 0 : go;
	end
end


assign pulse= go;
assign ready = !go;


endmodule
