library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library six_alpha;
use six_alpha.programming.all;



entity inst_mem is
	port(	clk:		in  std_logic;
			clk_p:	in  std_logic;
	
			addr:		in  std_logic_vector(6 downto 0);
			
			d_out:	out  std_logic_vector(7 downto 0)
			);
end inst_mem;



architecture behavioral of inst_mem is

	signal rom: PRG_MEM_ARRAY := PRG_IMAGE;
		
begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if(clk_p = '0') then
			
				d_out <= rom(to_integer(unsigned(addr)));
			
			end if;
		end if;
	end process;

end behavioral;