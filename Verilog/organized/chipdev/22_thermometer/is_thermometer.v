module model #(parameter
    DATA_WIDTH = 8
) (
    input [DATA_WIDTH-1:0] codeIn,
    output reg isThermometer
);

integer i; 
reg [$clog2(DATA_WIDTH):0] c;

always @(*) begin
    c=0;
    for (i=0; i<DATA_WIDTH-1; i++) begin
        c= codeIn[i]^codeIn[i+1] ? c+1 : c;
    end
end

assign isThermometer = c==1;

endmodule
