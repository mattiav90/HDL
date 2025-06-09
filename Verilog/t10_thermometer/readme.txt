Thermometer (a.k.a. unary) coding is frequently used in digital
 systems applications to represent a natural number.  In a thermometer 
 code, a N-bit binary number is represented by a (2 ** N)-bit digital word,
  which has m zeros followed by (N - m) ones or vice-versa.

Implement a thermometer code detector.  The module has two ports, 
codeIn and isThermemeter.  The former is a DATA_WIDTH-bit unsigned
 binary word, and the latter is the signal that indicates whether or
  not the input is a thermometer code.  The circuit must support 
  both types of thermometer representations.  For instance, for an 
  input word that is N-bit long, the detector must detect thermometer 
  representations that use m zeros followed by (N - m) ones or m ones
   followed by (N - m) zeros.  Output isThermemeter is one when a 
   thermometer word is detected at the input and zero otherwise.
