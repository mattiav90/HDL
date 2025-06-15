
this is a 32 bit priority encorder broken down into 4 8bit priority encoders.
each one of the 4 encorders compute 8 bit in parallel, then the valid output of this 4 is used 
and sent into another priority encoder to see which one has the  highest 1. 

the 2 stages are pipelined 


8bit -> [] -> 4bit -> []

8bit -> [] -> 4bit -> []
							-> output
8bit -> [] -> 4bit -> []

8bit -> [] -> 4bit -> []


basically the output of the first 4 (8bit) encoders  is pipelined.
then that is taken, send through combinatorial logic (4bit encoder)
then that is taken, pipelined again, and sent to the output. 

do not connect combinatorial logic direcly to the output because might crate litches. 

always register the output signals. 
