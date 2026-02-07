#!/bin/bash
set -e

iverilog -g2012 model_test.sv test.sv
vvp a.out 
gtkwave wave.vcd
