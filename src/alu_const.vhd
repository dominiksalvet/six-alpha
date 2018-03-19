library ieee;
use ieee.std_logic_1164.all;



package alu_const is

	constant AO_SB:		std_logic_vector(2 downto 0) := "000";
	constant AO_SNB:		std_logic_vector(2 downto 0) := "001";
	constant AO_SETB:		std_logic_vector(2 downto 0) := "010";
	constant AO_CLRB:		std_logic_vector(2 downto 0) := "011";
	constant AO_ADD:		std_logic_vector(2 downto 0) := "100";
	constant AO_SUB:		std_logic_vector(2 downto 0) := "101";
	constant AO_XOR:		std_logic_vector(2 downto 0) := "110";
	constant AO_NAND:		std_logic_vector(2 downto 0) := "111";

end alu_const;
