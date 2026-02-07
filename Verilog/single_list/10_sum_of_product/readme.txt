

receive x and w from the input, they have ready-valid
in common. 

in this problem  you can absorb back pressure 
as long as you are still filling up 
the psum. 

even if downstream cannot receive, continue to
psum cumulate untill you reach the end of the 
cumulation and you can assert the output. 

att this point stall untill the downstream is 
ready to receive. 

