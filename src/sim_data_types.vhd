library ieee;
use ieee.std_logic_1164.all;



package sim_data_types is
	
	type dm_sim_data_type is record
		wr_en:	std_logic;
		cf_set:	std_logic;
		zf_set:	std_logic;
		mem_0:	std_logic_vector(3 downto 0);
		mem_1:	std_logic_vector(3 downto 0);
		mem_2:	std_logic_vector(3 downto 0);
		mem_3:	std_logic_vector(3 downto 0);
		mem_4:	std_logic_vector(3 downto 0);
		mem_5:	std_logic_vector(3 downto 0);
		mem_6:	std_logic_vector(3 downto 0);
		mem_7:	std_logic_vector(3 downto 0);
		mem_8:	std_logic_vector(3 downto 0);
		mem_9:	std_logic_vector(3 downto 0);
		mem_10:	std_logic_vector(3 downto 0);
		mem_11:	std_logic_vector(3 downto 0);
		scr:		std_logic_vector(3 downto 0);
		pout:		std_logic_vector(3 downto 0);
		pin:		std_logic_vector(3 downto 0);
		paddr:	std_logic_vector(3 downto 0);
	end record;
	
	type core_sim_data_type is record
		clk_phase:		std_logic;
		a_reg:			std_logic_vector(3 downto 0);
		ip_reg:			std_logic_vector(6 downto 0);
		a_reg_wr_en:	std_logic;
		inst_word:		std_logic_vector(7 downto 0);

		alu_c_flag:		std_logic;
		alu_z_flag:		std_logic;
		alu_s_flag:		std_logic;

		dm_addr:			std_logic_vector(3 downto 0);
		dm_d_out:		std_logic_vector(3 downto 0);
		dm_sim:			dm_sim_data_type;
	end record;

end sim_data_types;
