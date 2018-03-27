# Six Alpha Processor

Six Alpha is a 4-bit RISC processor architecture implemented as a softcore processor described in VHDL. It is based on my first processor I described in VHDL. The whole code in the very moment is in it's original form.

There is the TODO list stated below. I am going to work on it as soon as the Limen Alpha processor repository will in a stable state.

## TODO list:
* remove [`sim_data_types.vhd`](src/sim_data_types.vhd) as deprecated way of simulating modules
* use generic modules from my [vhdl_collection](https://github.com/dominiksalvet/vhdl_collection) repository
* rename source files to be consistent across all my projects
* remaster the following source files (the first iteration - code formatting):
  * [`alu.vhd`](src/alu.vhd)
  * [`alu_const.vhd`](src/alu_const.vhd)
  * [`core.vhd`](src/core.vhd)
  * [`core_const.vhd`](src/core_const.vhd)
  * [`data_mem.vhd`](src/data_mem.vhd)
  * [`data_mem_const.vhd`](src/data_mem_const.vhd)
  * [`inst_mem.vhd`](src/inst_mem.vhd)
  * [`programming.vhd`](src/programming.vhd)
* transfer test bench files
* create a basys2 implementation
* remaster all VHDL module's files (the second iteration - light optimization, commenting)
* remaster all test bench files (create meaningful simulations, commenting)
* transfer documentation files
* transfer common software for the processor
* create a testing software for the basys2 implementation
* create a meaningful [`README.md`](README.md) file

## License

This project is licensed under the MIT License, see the [`LICENSE.txt`](LICENSE.txt) file for details.
