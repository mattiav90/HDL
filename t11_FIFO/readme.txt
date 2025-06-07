
this folder contain different implementations of a fifo.

- fifo0.v
fifo 0 is a simple implementation of a wrap around fifo.
this implementation uses pointers to keep track if the fifo is full
or empty. the bit width is exactly what is needed, so to avoid
confusion between empty and full, one fifo element is not used.

- fifo1.v
this implementation uses one extra bit for the read and write 
pointers. in this way, there is one bit that allows to see if the 
fifo has completed a wrap around or not. 
it uses all the fifo entries.

- fifo2.v
this implementation uses a counter. the counter makes it easier 
to check whethere it is full or empty, but it adds an adder, that
is actually non necessary. 
the adder become critical for performance. 

