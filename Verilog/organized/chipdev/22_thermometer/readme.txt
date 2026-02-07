Implement a thermometer code detector.  The module has two ports, 
codeIn and isThermemeter.  The former is a DATA_WIDTH-bit unsigned
 binary word, and the latter is the signal that indicates whether or
not the input is a thermometer code.  The circuit must support 
both types of thermometer representations.  For instance, for an 
input word that is N-bit long, the detector must detect
thermometer representations that use m zeros followed by (N - m)
ones or m ones followed by (N - m) zeros.  Output isThermemeter
is one when a thermometer word is detected at the input and 
zero otherwise.

Input and Output Signals
codeIn - Thermometer input word
isThermometer - Output bit that indicates whether or not an inpu
t word is a
thermometer code
