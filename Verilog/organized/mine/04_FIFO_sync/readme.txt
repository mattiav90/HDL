
this folder contains 2 different implementations of fifo.

fifo0 is less efficient and counts how many elements have been loaded.
the counter is usefull in case the almost full and empty signals are needed


fifo2 instead is more efficeint. it uses the wrap around bit to keep truck
if the buffer is full or empty. 
when w_ptr==r_ptr, then it is empty
when (w_ptr[w]!=r_ptr[w]) & (w_ptr[w-1:0]==r_ptr[w-1:0]) it is full.



there is also another type of fifo. that ises the idex for write and read
that are exactly the right width, but sets full as:
full => w_ptr=r_ptr-1
empty => w_ptr==r_ptr

this version does not use a locaiton in the fifo. 
an example is implemented in tests folder


