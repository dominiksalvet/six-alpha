library ieee;
use ieee.std_logic_1164.all;

library six_alpha;
use six_alpha.sim_data_types.all;



entity core_tb is
end core_tb;



architecture behavioral of core_tb is

	component core
		generic(	sim_en:	boolean := true
					);
		port(	clk:		in  std_logic;
				rst:		in  std_logic;
				
				pin:		in  std_logic_vector(3 downto 0);
				
				paddr:	out  std_logic_vector(3 downto 0);
				pout:		out  std_logic_vector(3 downto 0);
				
				sim:		out  core_sim_data_type
				);
	end component;

	signal clk:		std_logic := '0';
	signal rst:		std_logic := '0';
	
	signal pin:		std_logic_vector(3 downto 0) := (others => '0');

	signal paddr:	std_logic_vector(3 downto 0);
	signal pout:	std_logic_vector(3 downto 0);
	
	signal sim:		core_sim_data_type;


	constant CLK_PERIOD:		time := 10 ns;

begin

	uut: core port map(
		clk =>		clk,
		rst =>		rst,
		pin =>		pin,
		paddr =>		paddr,
		pout =>		pout,
		
		sim =>		sim
		);


	clk_proc: process
	begin
		clk <= '0';
		wait for CLK_PERIOD/2;
		clk <= '1';
		wait for CLK_PERIOD/2;
	end process;
	
	
	stim_proc: process
	begin

		rst <= '1';
		wait for 10 ns;
		
		rst <= '0';
		pin <= "0100";
		wait;
		
	end process;

end behavioral;
