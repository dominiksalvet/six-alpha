library ieee;
use ieee.std_logic_1164.all;



package data_mem_const is

	constant RST_SCR:		std_logic_vector(3 downto 0) := "0000";
	constant RST_PADDR:	std_logic_vector(3 downto 0) := "0000";
	
	constant MA_SCR:		integer := 12;
	constant MA_POUT:		integer := 13;
	constant MA_PIN:		integer := 14;
	constant MA_PADDR:	integer := 15;

end data_mem_const;