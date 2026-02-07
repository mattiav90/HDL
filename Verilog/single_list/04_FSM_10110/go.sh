#!/bin/bash
set -e 

iverilog -g2012 FSM_overlap_test.sv test_overlap.sv
vvp a.out
gtkwave wave.vcd
