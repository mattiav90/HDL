module model #(parameter
    FIZZ=3,
    BUZZ=5,
    MAX_CYCLES=100
) (
    input clk,
    input resetn,
    output logic fizz,
    output logic buzz,
    output logic fizzbuzz
);

reg [$clog2(MAX_CYCLES):0] c;

always @(posedge clk) begin
if (!resetn) begin
    c=0;
end else begin
    c = (c==MAX_CYCLES-1) ? 0 : c+1;
end
end


assign fizz     = c%FIZZ==0;
assign buzz     = c%BUZZ==0;
assign fizzbuzz = c%FIZZ==0 && c%BUZZ==0;


endmodule
