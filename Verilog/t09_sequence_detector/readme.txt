Given a stream of input bits, pulse a 1 on the output (dout) whenever
 a b1010 sequence is detected on the input (din).

When the reset-low signal (resetn) goes active, all previously seen
 bits on the input are no longer considered when searching for b1010.

Input and Output Signals
clk - Clock signal
resetn - Synchronous reset-low signal
din - Input bits
dout - 1 if a b1010 was detected, 0 otherwise
