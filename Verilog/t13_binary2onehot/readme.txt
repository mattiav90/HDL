
here I will implement a binary to one hot converter 
and a one hot  to binary converter.


Binary to One-Hot: Convert an n-bit binary input into a 2ⁿ-bit one-hot output.

One-Hot to Binary: Convert a 2ⁿ-bit one-hot input into an n-bit binary output.



binary to one-hot. 
for binary to one hot, I used 2 possible solutions. 
one is with a wire assignment and the second one is with a shifter. 


one-hot to binary. 
I also implemented 2 solutions here. 

one involves sintax repetition with a for loop. might be redundant. 
the second implementatio has one stage pipeline, but more importantly uses casex.
with casex the rtl will map it to a single mux and a lot of cases are skipped thanks to the x. 




----- 

I also implement a 16 bit version pipelining it. 
the 16 bit version does not just use a huge 2^16 mux possibility. 
but split in an interesting way the bits. 

