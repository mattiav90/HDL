Prompt
Given a value, output its index in the standard Gray code sequence.
 This is known as converting a Gray code value to binary.

Each input value's binary representation is an element in the Gray 
code sequence, and your circuit should output the index of the Gray
 code sequence the input value corresponds to.

In the standard encoding the least significant bit follows a 
repetitive pattern of 2 on, 2 off ( ... 11001100 ... ); the next
 digit a pattern of 4 on, 4 off ( ... 1111000011110000 ... ); the
  nth least significant bit a pattern of 2n on 2n off.

Input and Output Signals
gray - Input signal, interpreted as an element of the Gray code 
sequence
bin - Index of the Gray code sequence the input corresponds to



remember that from binary to gray is super simple and is like this

gray = bin ^ (bin>>1);


from gray to binary is more tricky.

bin[W-1]=gray[W-1];
for (i=W-1;i>0;i--) begin
	bin[i-1] = bin[i] ^ gray[i-1]
end
