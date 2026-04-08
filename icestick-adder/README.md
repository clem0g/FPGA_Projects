# icestick-adder

## Overview
 Adder between 3 binary numbers (1 or 0) (2 bit adder) Represented by button presses to add and result represented by lights going on or off or both module adder(

## File types
- Verilog: yes
- VHDL: no
- Constraints (.pcf): yes

## Files
- adder.pcf
- adder.v

## Modules / Entities
- Modules: adder(

## Targets and toolchain
- Board: iCEstick (Lattice iCE40HX1K)
- Toolchain: IceStorm + Apio (yosys/nextpnr/icestorm)

## Build and upload (Apio)
```bash
apio build
apio upload
```

## Notes
- Inputs are read from PMOD pins; outputs drive LEDs.
- See the `.pcf` constraints for exact pin mapping.
