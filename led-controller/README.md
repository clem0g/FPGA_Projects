# iCEstick LED "Hello World" (Verilog)

This project is a minimal FPGA design for the Lattice iCEstick board.  
The top module drives the 5 user LEDs, turning on `D1`, `D2`, `D4`, and `D5`, while `D3` is off.

The repository includes:

- Synthesizable Verilog source (`leds.v`)
- Pin constraints for iCEstick (`leds.pcf`)
- APIO project configuration (`apio.ini`)
- A simulation testbench (`leds_tb.v`)

## Project Structure

- `leds.v`: top-level HDL module (`leds`)
- `leds.pcf`: physical pin mapping for the 5 LEDs
- `apio.ini`: APIO environment configuration (`board = icestick`, `top-module = leds`)
- `leds_tb.v`: testbench for waveform simulation
- `info`: short project note

## What the Design Does

The module has five output ports:

- `D1 = 1`
- `D2 = 1`
- `D3 = 0`
- `D4 = 1`
- `D5 = 1`

When programmed onto the board, this yields a fixed LED pattern.

## Prerequisites

- iCEstick FPGA board
- USB connection to the board
- APIO toolchain installed (with iCE40 support)
- For simulation: `iverilog` and `vvp`
- Optional waveform viewer: `gtkwave`

## Build and Upload to iCEstick

From this project directory:

```bash
apio build
apio upload
```

`apio build` synthesizes, places, and routes the design.  
`apio upload` programs the generated bitstream to the iCEstick board.

## Run Simulation

Generate and run the testbench:

```bash
iverilog -o leds_tb.out leds.v leds_tb.v
vvp leds_tb.out
```

This produces `leds_tb.vcd` for waveform inspection.

Open the waveform (optional):

```bash
gtkwave leds_tb.vcd
```

## Notes

- Generated build/simulation files are ignored via `.gitignore`.
- This is a good starter template for learning iCE40 FPGA flows and basic Verilog module/testbench structure.
