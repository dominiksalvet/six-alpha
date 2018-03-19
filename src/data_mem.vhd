library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library six_alpha;
use six_alpha.data_mem_const.all;
use six_alpha.sim_data_types.all;



entity data_mem is
	generic(	sim_en:	boolean := false
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
end data_mem;



architecture behavioral of data_mem is

	type mem_array is array (15 downto 0) of std_logic_vector(3 downto 0);
	signal rwm: mem_array := (others => (others => '-'));
	
	signal sim_sig:	dm_sim_data_type;

begin

	d_out <=	pin when addr = std_logic_vector(to_unsigned(MA_PIN, addr'length))
				else rwm(to_integer(unsigned(addr)));
				
	paddr <= rwm(MA_PADDR);
	
	pout <= rwm(MA_POUT);
	
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(rst = '1') then
			
				rwm(MA_SCR) <= RST_SCR;
				rwm(MA_PADDR) <= RST_PADDR;
				
			elsif(clk_p = '1') then
				
				if(wr_en = '1') then
					rwm(to_integer(unsigned(addr))) <= d_in;
				end if;
				
				if(cf_set = '1') then
					rwm(MA_SCR)(3) <= alu_cf;
				end if;
				
				if(zf_set = '1') then
					rwm(MA_SCR)(2) <= alu_zf;
				end if;
				
			end if;
		end if;
	end process;
	
	
	sim_sig.wr_en <= wr_en;
	sim_sig.cf_set <= cf_set;
	sim_sig.zf_set <= zf_set;
	sim_sig.mem_0 <= rwm(0);
	sim_sig.mem_1 <= rwm(1);
	sim_sig.mem_2 <= rwm(2);
	sim_sig.mem_3 <= rwm(3);
	sim_sig.mem_4 <= rwm(4);
	sim_sig.mem_5 <= rwm(5);
	sim_sig.mem_6 <= rwm(6);
	sim_sig.mem_7 <= rwm(7);
	sim_sig.mem_8 <= rwm(8);
	sim_sig.mem_9 <= rwm(9);
	sim_sig.mem_10 <= rwm(10);
	sim_sig.mem_11 <= rwm(11);
	sim_sig.scr <= rwm(12);
	sim_sig.pout <= rwm(13);
	sim_sig.pin <= pin;
	sim_sig.paddr <= rwm(15);
	
	sim_switch:
	if(sim_en = true) generate
		sim <= sim_sig;
	end generate sim_switch;

end behavioral;