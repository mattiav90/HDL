this is the implementation of a priority encoder. 
it will return the position of the MSB that is =1. 


casez allows for whild card matching, so is efficient in synthesis. 
it does not have much logic so it has a fast critical path.


----------------------------------------------------------------

-  by breaking down the computation in 2 stages I REDUCE THE LOGIC DEPTH of each stage. 
so I can run at higher frequency. 

-  the tree based approach allows me to reduce the computational complexity from O(N)
   to O(log(N)).

- pipeline stage reduce the critical path.

- Register at input side (optional third pipeline stage):

If inputs come from high-speed domains, consider registering in to decouple source logic timing.


----------------------------------------------------------------

this enoder implements pipelining. breaks the input into 4 chuncks. 
compute them in parallel, then combine the results into one. 
breaking the input into multiple chunks helps because if you just write a 
32 bit encoder, then there might be very long chains of mux (if else)
but breaking it down in separated parts computed in parallell is faster. 

(tree based repartition)


Priority Encoder Tree (Hierarchical)
You can construct a tree of smaller encoders:

For example, a 32-bit input can be split into four 8-bit chunks.

Run 4 × priority_encoder_8 in parallel.

Use another priority_encoder_4 to choose which chunk has the highest-priority bit.

Final result = (chunk index << 3) | local encoder result


--------------------------------------------------------------------

Here’s the basic idea (not full code):

Break input into N-bit chunks.

Use small encoders (e.g., 4-bit or 8-bit) in parallel.

Use a second stage to combine their results.

Register intermediate results for timing.

This gives you a tree-based, low-latency, pipelined encoder.

