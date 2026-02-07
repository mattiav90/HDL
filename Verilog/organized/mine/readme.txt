
steps:

write a verilog file, 
write teststbench

iverilgo -out sim.out module.v test.v

vvp sim.out

gtkwave wave.vcd
