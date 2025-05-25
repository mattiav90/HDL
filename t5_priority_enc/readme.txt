this is the implementation of a priority encoder. 
it will return the position of the MSB that is =1. 


casez allows for whild card matching, so is efficient in synthesis. 
it does not have much logic so it has a fast critical path.


-> if I want to implement bigger priority encoders, I can do it by pipelining
the implementation to increase throughput.

basically I can split the computation in 2 stages.

say that I want to implement a 32 bit encoder. 
I can use 4 8bit encoders that runs in parallel. 
then take their output and figure out the final output. 

in this way I split the computation in 2 sections and I introduce pipelining.
