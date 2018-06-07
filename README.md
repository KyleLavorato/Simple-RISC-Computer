# Simple RISC Computer
---
## System Introduction

This repository holds the Hardware Description Language definition for a simple 32-bit, single bus RISC style computer in the Verilog language. The computer is fully functional, implementing a basic instruction set, built in the Altera Quartus II software and simulated through the ModelSim software. It may also be synthesized on a physical Cyclone FPGA chip. Notable hardware includes a full Arithmetic Logic Unit (ALU), Inferred RAM Module, Memory Stack and Control Logic state machines.

## Computer Design

The system is created in an object oriented style, with each Verilog file defining one unit of the system. The root system is defined and implemented in `computer.v`. The system was incrementally designed and tested in three phases, through the use of testbenches. The computer project can be opened in Altera Quartus II from the `computer.qpf` file.

## Documentation

The `/Documentation` directory contains both the original design specification the the system was built according to and technical reports which apply real test cases to the system to prove its functionality, with results. Also included is custom instructions and hardware added to the original specification to further improve the system.

# Instruction Set
---
The system implements the following basic 5-bit instruction set

### Load and Store Instructions
* Load Direct: ```ld Ra, C```
* Load Indexed: ```ld Ra, C(Rb)```
* Load Immediate: ```ldi Ra, C```
* Load Relative: ```ldr Ra, C```
* Store Direct: ```st C, Ra```
* Store Indexed: ```st, C(Rb), Ra```
* Store Relative: ```str C, Ra```

### Arithmetic and Logical Instructions
* Add: ```add Ra, Rb, Rc```
* Add Immediate: ```addi Ra, Rb, C```
* Subtract: ```sub Ra, Rb, Rc```
* And: ```and Ra, Rb, Rc```
* And Immediate: ```andi Ra, Rb, C```
* Or: ```or Ra, Rb, Rc```
* Or Immediate: ```ori Ra, Rb, C```
* Multiply: ```mul Ra, Rb```
* Divide: ```div Ra, Rb```
* Negate: ```neg Ra, Rb```
* Not: ```not Ra, Rb```
* Shift Right: ```shr Ra, Rb, Rc```
* Shift Left: ```shl Ra, Rb, Rc```
* Rotate Right:```ror Ra, Rb, Rc```
* Rotate Left: ```rol Ra, Rb, Rc```

### Conditional Branch Instructions
* Branch if Zero: ```brzr Ra, C```
* Branch if NonZero: ```brnz Ra, C```
* Branch if Positive: ```brpl Ra, C```
* Branch if Negative: ```brmi Ra, C```

### Jump Instructions
* Return from Procedure: ```jr Ra```
* Jump and Link: ```jal Ra```

### Input/Output Instructions
* Input: ```in Ra```
* Output: ```out Ra```
* Move from HI: ```mfhi Ra```
* Move from LO: ```mflo Ra```

### Control Instructions
* No-Operation: ```nop```
* Halt: ```halt```

### Extended Instructions
* Increment: ```inc Ra```
* Load from Stack: ```ldstk Ra```
* Store on Stack: ```ststk Ra```

## Instruction Assembler
---
A custom written assembler in Python 3 is provided for the computer in the `/Assembler/assembler.py` file. This assembler is pre-compiled from the source, and takes an input file named `code.asm` to produce an assembled output in binary for input to this computer in the file `assembled.asm`. To run the assembled code, it must be loaded into the RAM of the computer in `ram512.v` or loaded through a Memory Initialization File (mif).