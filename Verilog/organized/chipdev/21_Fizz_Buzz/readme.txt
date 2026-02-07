Prompt
Design a circuit that counts incrementally for a maximum number of cycles, MAX_CYCLES.   At all cycles, the circuit should determine whether or not the counter value is evenly divisible by parameters FIZZ, BUZZ, or both.  

The counter value should monotonically increase when the reset signal (resetn) is de-asserted. The counter sequence is expected to start from 0 and be MAX_CYCLES long, restarting from 0 when MAX_CYCLES is reached (e.g. for MAX_CYCLES = 100:  0, 1, 2, 3, ..., 99, 0, 1, ...).

As the circuit counts, output fizz should be asserted if the current counter value is evenly divisible by FIZZ.  buzz should output 1 when the current counter value is divisible by BUZZ.  Finally, output fizzbuzz should be 1 when counter is evenly divisible by both FIZZ and BUZZ. 

Input and Output Signals
clk - Clock signal
resetn - Synchronous, active low, reset signal
fizz - Output Fizz
