library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library six_alpha;
use six_alpha.sim_data_types.all;



entity data_mem_tb is
end data_mem_tb;



architecture behavior of data_mem_tb is

	component data_mem
		generic(	sim_en:	boolean := true
					);
		port(	clk:		in  std_logic;
				clk_p:	in  std_logic;
				rst:		in  std_logic;
				
				wr_en:	in  std_logic;
				alu_cf:	in  std_logic;
				alu_zf:	in  std_logic;
				cf_set:	in  std_logic;
				zf_set:	in  std_logic;
				addr:		in  std_logic_vector(3 downto 0);
				d_in:		in  std_logic_vector(3 downto 0);
				
				d_out:	out  std_logic_vector(3 downto 0);
				
				pin:		in  std_logic_vector(3 downto 0);
				
				paddr:	out  std_logic_vector(3 downto 0);
				pout:		out  std_logic_vector(3 downto 0);
				
				sim:		out  dm_sim_data_type
				);
	end component;

	signal clk:		std_logic := '0';
	signal clk_p:	std_logic := '0';
	signal rst:		std_logic := '0';
	
	signal wr_en:		std_logic := '0';
	signal alu_cf:		std_logic := '0';
	signal alu_zf:		std_logic := '0';
	signal cf_set:		std_logic := '0';
	signal zf_set:		std_logic := '0';
	signal addr:		std_logic_vector(3 downto 0) := (others => '0');
	signal d_in:		std_logic_vector(3 downto 0) := (others => '0');
	
	signal d_out:	std_logic_vector(3 downto 0);
	
	signal pin:		std_logic_vector(3 downto 0) := (others => '0');
	
	signal paddr:	std_logic_vector(3 downto 0);
	signal pout:	std_logic_vector(3 downto 0);
	
	signal sim:		dm_sim_data_type;
	
	
	constant CLK_PERIOD:		time := 10 ns;

begin

	uut: data_mem port map(
		clk =>		clk,
		clk_p =>		clk_p,
		rst =>		rst,
		wr_en =>		wr_en,
		alu_cf =>	alu_cf,
		alu_zf =>	alu_zf,
		cf_set =>	cf_set,
		zf_set =>	zf_set,
		addr =>		addr,
		d_in =>		d_in,
		d_out =>		d_out,
		pin =>		pin,
		paddr =>		paddr,
		pout =>		pout,
		
		sim =>		sim
		);


	clk_proc: process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	
	
	aux_proc: process
	begin
		
		alu_cf <= '1';
		alu_zf <= '1';
		wait for 40 ns;
		
		clk_p <= '1';
		wait for 20 ns;
		
		wr_en <= '1';
		wait for 40 ns;
		
		wr_en <= '0';
		cf_set <= '1';
		zf_set <= '1';
		wait for 20 ns;
		
		alu_cf <= '0';
		alu_zf <= '0';
		clk_p <= '0';
		wait for 20 ns;
		
		clk_p <= '1';
		wait;
		
	end process;


	stim_proc: process
	begin
		
		rst <= '1';
		wait for 10 ns;
		
		rst <= '0';
		
		loop
			
			wait for 10 ns;
			
			addr <= std_logic_vector(unsigned(addr) + 1);
			d_in <= std_logic_vector(unsigned(d_in) + 2);
			
		end loop;
		
	end process;

end;