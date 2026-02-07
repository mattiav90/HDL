Prompt
Divide an input number by a power of two and round the result to
the nearest integer. The power of two is calculated using 2DIV_LOG2
where DIV_LOG2 is a module parameter. Remainders of 0.5 or greater
should be rounded up to the nearest integer. If the output were 
to overflow, then the result should be saturated instead.

Input and Output Signals
din - Input number
dout - Rounded result




If din = 0xb and DIV_LOG2 = 2, we can calculate dout like this:

dout = din⁄2DIV_LOG2
= 0xb⁄22
= 11⁄4
= 2.75
= 3 (rounded)

