library ieee;
use ieee.std_logic_1164.all;



package programming is

	type PRG_MEM_ARRAY is array (127 downto 0) of std_logic_vector(7 downto 0);
	
	constant PRG_IMAGE: PRG_MEM_ARRAY := (
	
		-- == Read and count ==
		-- read value from port 2, then count from zero to this value, then do it again
		-- show actual value on port 1

		0 => "00010000",	-- LI 0
		1 => "00111100",	-- ST 12
		2 => "00010000",	-- LI 0
		3 => "00110000",	-- ST 0
		4 => "00010010",	-- LI 2
		5 => "00111111",	-- ST 15
		6 => "00101110",	-- LD 14
		7 => "00110001",	-- ST 1
		8 => "00010001",	-- LI 1
		9 => "00110010",	-- ST 2
		10 => "00100000",	-- LD 0
		11 => "00111101",	-- ST 13
		12 => "00011001",	-- LI 9
		13 => "00111111",	-- ST 15
		14 => "00100000",	-- LD 0
		15 => "01000010",	-- ADD 2
		16 => "00110000",	-- ST 0
		17 => "00100001",	-- LD 1
		18 => "01010010",	-- SUB 2
		19 => "00110001",	-- ST 1
		20 => "00101100",	-- LD 12
		21 => "00000011",	-- SB 3
		22 => "10001010",	-- JMP 10
		23 => "10000000",	-- JMP 2
		
		others => (others => '-')
		);

end programming;