


there is a valid, ready input of 4 bits (pulse_length).
there is a single bit of output "pulse".
the module will assert pulse to high for the number of cycles encoded by "pulse_length".
module will assert ready to get the next "pulse_length" value. 

valid - ready protocol overview: 
pulse_length input has valid data when valid is asserted
valid will remain high untill module asserts "ready"

pulse_length value will not change as long as "valid" is high and "ready" is low
handshake coours when "valid" and "ready" are high in the same clock cycle, 
pulse_length may change or go away in he  next cycle. 


one thing to notice is that the module should also be able to take in input a pulse_length
of 0. so just acknowledge the data, and send out a pulse of length 0. 

