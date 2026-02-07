Prompt
Design a module that determines whether an input value is evenly divisible by five.

The input value is of unknown length and is left-shifted one bit at a time into the module via the input (din). The module should output a 1 on the output (dout) if the current cumulative value is evenly divisible by five and a 0 otherwise.

When resetn is asserted, all previous bits seen on the input are no longer considered. The 0 seen during reset should not be included when calculating the next value.

This problem is tricky, so it may help to think in terms of modulus and remainder states.

Input and Output Signals
clk - Clock signal
resetn - Synchronous reset-low signal
din - Input bit
dout - 1 if the current value is divisible by 5, 0 otherwise.
Output signals during reset
dout - 0 when resetn is active


again here the trick it to know that you can keep truck of the
reminder by iusing a finite state machine. 


Binary Modulo-5 FSM Property
If you're receiving a binary number bit-by-bit (MSB first),
then you can compute its modulo-5 remainder with a FSM,
where each state represents one of the remainders {0,1,2,3,4}.

Each new bit updates the remainder like this:


new_rem = (rem * 2 + din) % 5


each MOD value is actrually the rem. 

so if you have MOD1, then you get 


new_rem = ( 1 * 2 + din ) % 5


for MOD2 you have

new_rem = ( 2 * 2 + din ) % 5 


etch...
