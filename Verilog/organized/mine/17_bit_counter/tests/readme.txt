

this is the implementation for a bit counter. 

in the simple version, the tool might create a chain of adders. that might
 be slow if the bit width gets bigger. 


in the optimized case, I create a tree structure. 
that allows to compute parts in parallel. 

