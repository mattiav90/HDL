
there is a valid ready input of 4 bits (pulse_length).
there is a single bit of output "pulse".
the module will assert pulse to hihgh fot the number of cycles encoded by "pulse_length".
module will assert ready to get the next "pulse_length" value. 

// valid - ready protocol overview: 
pulse_length input has valid data when valid is asserted
valid will remain high untill module asserts "ready"

pulse_length value will not change as long as "valid" is high and "ready" is low
handshake coours when "valid" and "ready" are high in the same clock cycle, 
pulse_length may change or go away in he  next cycle. 



// one thing to notice is that the module should also be able to take in in input a pulse_length
of 0. so just acknowledge the data, and send out a pulse of length 0. 



// the follow up of this quesiton, is:

# this is the NO BUBBLE version

notice that right now to welcome a new valid pulse_count, you need to have completed a 
previous pulse. 
can you think of a way to welcome more pulse_length while he pulse is stil high?
so  you can send back to back pulse_length, and the pulse in output will just comulate. 

also there is no need for the pulse to go down before welcoming a new pulse_length. 
