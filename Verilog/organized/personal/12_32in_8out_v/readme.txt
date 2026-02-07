
You are given a stream of 32-bit input words (din), each accompanied by a
 valid signal. Inside this stream, think of the data as a sequence of 
 8-bit elements packed into the 32-bit words (4 bytes per word).
You also receive a compile-time parameter:

parameter int CATCH = N;
This parameter represents the index of the 8-bit element that you must
 output from the stream (0-based indexing). For example:
	•	CATCH = 0 → output the very first byte of the first word
	•	CATCH = 6 → skip the first 6 bytes and output the 7th byte,
	 which is byte index 2 of the second 32-bit word
Design a Verilog module that:
	2	Extracts the correct 8-bit value from the sequence of incoming 
	words. 
	3	Asserts an output valid signal (dout_valid) only for the cycle
	 when the selected byte is available.
	
You may assume that:
	•	Input words arrive sequentially, one per cycle when valid = 1.
	•	CATCH is known at compile time (a parameter).


