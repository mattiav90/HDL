ccompute the dot product of K elements
they come from 2 separate channels with ready-valid protocol
when both of the input channels can be taken, consume the input tokens
and comulate into the dot product

when you completed the K PSUMs, then assert that  you are 
done and ready-valid handshake with the output 

