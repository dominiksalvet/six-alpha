library ieee;
use ieee.std_logic_1164.all;

library six_alpha;
use six_alpha.alu_const.all;



package core_const is

	constant RST_IP_REG:		std_logic_vector(6 downto 0) := "0000000";

	constant BIT_INST_PREF:		std_logic_vector(3 downto 0) := "0000";

	constant LI_INST_PREF:		std_logic_vector(3 downto 0) := "0001";
	constant LD_INST_PREF:		std_logic_vector(3 downto 0) := "0010";
	constant ST_INST_PREF:		std_logic_vector(3 downto 0) := "0011";
	constant ADD_INST_PREF:		std_logic_vector(3 downto 0) := '0' & AO_ADD;
	constant SUB_INST_PREF:		std_logic_vector(3 downto 0) := '0' & AO_SUB;

end core_const;