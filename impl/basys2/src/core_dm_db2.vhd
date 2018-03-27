library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library six_alpha;
use six_alpha.sim_data_types.all;



entity core_dm_db2 is
	port(	clk:			in  std_logic;
			rst:			in  std_logic;
			
			pin:			in  std_logic_vector(3 downto 0);
			
			clk_div:		in  std_logic_vector(3 downto 0);
			
			paddr:		out  std_logic_vector(3 downto 0);
			pout:			out  std_logic_vector(3 downto 0);
			
			seg_sel:		out  std_logic_vector(3 downto 0);
			seg_data:	out  std_logic_vector(7 downto 0)
			);
end core_dm_db2;



architecture behavioral of core_dm_db2 is

	component core is
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
	
	signal core_clk:	std_logic;
	
	signal core_sim:	core_sim_data_type;
	
	
	component seven_seg_contr_db2 is
		generic(	clk_div:		natural
					);
		port(	clk:			in  std_logic;
				
				data_in:		in  std_logic_vector(15 downto 0);
				
				seg_sel:		out  std_logic_vector(3 downto 0);
				seg_data:	out  std_logic_vector(7 downto 0)
				);
	end component;
	
	signal sscdb2_data_in:	std_logic_vector(15 downto 0);
	
	
	constant CLK_COUNT_WIDTH:	integer := 24;
	
	signal clk_count:		std_logic_vector(CLK_COUNT_WIDTH - 1 downto 0) := (others => '0');

begin

	core_0: core port map(
		clk =>		core_clk,
		rst =>		rst,
		pin =>		pin,
		paddr =>		paddr,
		pout =>		pout,
		
		sim =>		core_sim
		);
	
	
	seven_seg_contr_db2_0: seven_seg_contr_db2
	generic map(
		clk_div =>		100_000
		)
	port map(
		clk =>			clk,
		data_in =>		sscdb2_data_in,
		seg_sel =>		seg_sel,
		seg_data =>		seg_data
		);
		
	sscdb2_data_in <= (8 downto 0 => '0') & core_sim.ip_reg;
	
	
	process(clk)
	begin
		if(rising_edge(clk)) then
		
			if(
				clk_count(CLK_COUNT_WIDTH - 1 downto CLK_COUNT_WIDTH - 4) = clk_div and
				clk_count(CLK_COUNT_WIDTH - 5) = '1'
			) then
				core_clk <= '1';
				clk_count <= (others => '0');
			else
				core_clk <= '0';
				clk_count <= std_logic_vector(unsigned(clk_count) + 1);
			end if;
			
		end if;
	end process;

end behavioral;