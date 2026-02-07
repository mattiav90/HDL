#!/bin/bash
set -e

MODEL=model_test1.sv
TEST=test.sv
OUT_IV=a.out
WAV=wave.vcd

iverilog -g2012 $MODEL $TEST
vvp a.out
gtkwave wave*
