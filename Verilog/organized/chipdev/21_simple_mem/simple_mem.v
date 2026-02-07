
//remember to set error and dout in all the cases, to be sure 
//that they get updated correcty.
// also, rememeber also to introduce the no operation case. 
// so what happens if both read and write are 0 at some point. 


module model (
    input [7:0] din,
    input [2:0] addr,
    input wr,
    input rd,
    input clk,
    input resetn,
    output logic [7:0] dout,
    output logic error
);


reg [7:0] mem[7:0];
reg [7:0] used;



always @(posedge clk) begin
    if (!resetn) begin
        
        used<=0;
        dout<=0;
        error<=0;

    end else begin 

        if (wr && rd) begin     // not allowed
            error<=1;
            dout<=0;
        end else if (wr) begin  // write
            mem[addr]<=din;
            used[addr]<=1;
            error<=0;
            dout<=0;
        end else if (rd) begin  //read
            dout  <= used[addr] ? mem[addr] : 0 ;
            error <= used[addr] ? 0         : 0;
        end else begin          // no operation
            dout<=0;
            error<=0;
        end

    end


end


endmodule
