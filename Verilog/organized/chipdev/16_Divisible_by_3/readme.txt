Prompt
Design a circuit that determines whether an input value is evenly divisible by three.

The input value is of unknown length and is left-shifted one bit at a time into the circuit via the input (din). The circuit should output a 1 on the output (dout) if the current cumulative value is evenly divisible by three, and a 0 otherwise.

When resetn is asserted, all previous bits seen on the input are no longer considered. The 0 seen during reset should not be included when calculating the next value.

This problem is tricky, so it may help to think in terms of modulus and remainder states.

Input and Output Signals
clk - Clock signal
resetn - Synchronous reset-low signal
din - Input bit
dout - 1 if the current value is divisible by 3, 0 otherwise.
Output signals during reset
dout - 0 when resetn is asserted
