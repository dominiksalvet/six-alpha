# Six Alpha

![Six Alpha pipeline](doc/img/pipeline.png)

> Accumulator-based 4-bit processor.

Six Alpha is a 4-bit accumulator-based processor architecture implemented as a softcore processor described in VHDL. It is based on my [very first processor](https://github.com/dominiksalvet/pcycle) I have created in VHDL from 2015, which was tested on an Altera FPGA board. Later, it was ported to Digilent Basys 2 board.

The next traits include:

* Harvard memory architecture
* May address up to 128 B of instructions
* May address up to 16 nibbles of data
* I/O ports in data memory address space

## Machine Code

If you are curious what the machine code of Six Alpha looks like, browse the [collection of such programs](sw).

## Original Plan

The original intention was to design and release also the following Six processor.

### Six Beta

* Pipelining capability
* Instruction memory programming interface

## Useful Resources

* [support.md](support.md) – questions, answers, help
* [contributing.md](contributing.md) – how to get involve
* [license](license) – author and license
