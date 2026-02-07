#!/bin/bash
set -e

MODEL=model_test.sv
TEST=test.sv
SIM=a.out
WAVE=wave.vcd


iverilog -g2012 $MODEL $TEST
vvp $SIM
gtkwave $WAVE
