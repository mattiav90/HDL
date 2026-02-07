#!/bin/bash
set -e

iverilog -g2012 test.sv model.sv
vvp a.out
gtkwave wave.vcd
