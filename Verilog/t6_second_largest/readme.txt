Given a clocked sequence of unsigned values, output the second-largest 
value seen so far in the sequence. If only one value is seen, then the
output (dout) should equal 0. Note that repeated values are treated
as separate candidates for being the second largest value.

When the reset-low signal (resetn) goes low, all previous values seen
in the input sequence should no longer be considered for the calculation
of the second largest value, and the output dout should restart from 0
on the next cycle.
