# HDL & Python Exercises

This repository contains a collection of **practice exercises** in **HDL (Verilog/SystemVerilog)** and **Python**, created for **technical preparation** and **personal learning**.

The repository is **public and open**, and intended for study, experimentation, and skill refresh.

---

## Scope

### HDL (Verilog / SystemVerilog)
Most HDL exercises focus on:
- RTL design fundamentals
- Streaming / ready–valid interfaces
- FIFOs and buffering
- Fixed-point arithmetic and accumulations

Most Verilog/SystemVerilog problems include their own **testbench** to verify functionality.  
You are encouraged to use the provided testbenches, or design your own to explore alternative scenarios or edge cases.

### Python
Python exercises are mainly used for:
- Algorithmic reasoning
- Numerical and bitwidth analysis
- Hardware-related modeling and utilities

---

## Repository Structure

- Exercises are organized by **language and topic**
- Each problem folder contains a small **README** describing the task and expected behavior
- Solutions are intended to be **functionally correct, compact, and readable**

---

## Simulation & Tools

HDL simulations were tested using **Icarus Verilog** with SystemVerilog support enabled.

## Typical workflow:

iverilog -g2012 <dut.sv> <test.sv>
vvp a.out
gtkwave wave.vcd
Icarus Verilog:
https://formulae.brew.sh/formula/icarus-verilog

## Disclaimer
The exercises in this repository are either self-created or adapted from publicly available, open-source resources.
They are provided for educational purposes only.

## Have fun!