#!/bin/bash
set -e

iverilog -g2012 test.sv FIFO_test.sv
vvp a.out
gtkwave wave.vcd
