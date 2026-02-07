
when the ready valid signal from input handshake
receive a 16 bit element
when the downstream is ready to receive, push out
to the downstream, one bit at a time the content of 
the latched value

. the protocol for ready valid here is a credit type. 

basically when the module is ready to receive 
send out a ready token that last only 1 clock edge. 

for the right side or downstream, instead
the valid should be 1 any time a valid token is sent out
(and the downstream is ready to receive)

