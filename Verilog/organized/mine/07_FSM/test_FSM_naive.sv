`timescale 1ns/1ps

module test();

    logic clk;
    logic resetn;
    logic din;
    logic match;

    // Instantiate DUT
    FSM_naive dut (
        .clk(clk),
        .resetn(resetn),
        .din(din),
        .match(match)
    );

    // Clock generation (10 ns period → 100 MHz)
    initial begin
	clk=0;
	forever #5 clk=~clk;
    end

    // Task to send a single bit
    task go;
    begin
    	@(negedge clk);
        din = $random;
        @(posedge clk);
        $display("din: ",din," match: ",match);
    end
    endtask



    task composed;
    logic vec [3:0];
   	integer i;
	begin		
		vec[0]=1;
		vec[1]=0;
		vec[2]=1;
		vec[3]=1;

		for (i=0;i<4;i++ )begin
			 @(negedge clk);
			 din = vec[i];
			 @(posedge clk);
			 $display("din: ",din," match: ",match);
		end
	end
    endtask
	
    

    // Test sequence
    initial begin
        $display("=== Starting Pattern Detector Test ===");
        resetn = 0;
        din = 0;
        repeat (2) @(posedge clk);
        resetn = 1;

	    repeat (2)	composed;
		repeat (30) go;
		
        // Finish simulation
        repeat (4) @(posedge clk);
        $display("=== Test Complete ===");
        $finish;
    end


	initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
	end
    

endmodule
