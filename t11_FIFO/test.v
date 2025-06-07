module test;

	reg clk, rst_n;
	reg w_en, r_en;
	reg [7:0] data_in;
	wire [7:0] data_out;
	wire full, empty;	  
    fifo1 fifo(clk, rst_n, w_en, r_en, data_in, data_out, full, empty);

	initial begin
	clk = 0;
	forever #2 clk = ~clk;
	end

	//I like this a lot. 
	initial begin
	  clk   = 0; 						//reset everything
	  rst_n = 0;
	  w_en  = 0; 
	  r_en  = 0;
	  #3 rst_n = 1;	     			//deassert the reset.
	  repeat (2) @(posedge clk); 	//wait 2 clock cycles.
	  drive(20);					//start the test.
	  drive(40);					//test again
	  $finish;
	end

	 

	task push;
	  begin
	    if (!full) begin
	      w_en = 1;
	      data_in = $random;
	      $display("Push In: w_en=%b, r_en=%b, data_in=%h", w_en, r_en, data_in);
	      #2; w_en = 0;
	    end else begin
	      $display("FIFO Full!! Can not push data_in=%d", data_in);
	    end
	  end
	endtask


	task pop;
	  begin
	    if (!empty) begin
	      r_en = 1;
	      $display("Pop Out: w_en=%b, r_en=%b, data_out=%h", w_en, r_en, data_out);
	      #2; r_en = 0;
	    end else begin
	      $display("FIFO Empty!! Can not pop data_out");
	    end
	  end
	endtask

	// fork ... join in Verilog means run both branches of code 
	// in parallel (like threads).
	// the second thread is squed over a of delay from the first.
	
	  
	task drive;
	  input integer delay;
	  begin
	    w_en = 0; r_en = 0;
	    fork
	      begin
	        repeat(10) begin @(negedge clk) #1 push(); end
	      end
	      begin
	        #delay;
	        repeat(10) begin @(negedge clk) #1 pop(); end
	      end
	    join
	  end
	endtask

	  
	initial begin 
	  $dumpfile("dump.vcd"); $dumpvars;
	end


endmodule
