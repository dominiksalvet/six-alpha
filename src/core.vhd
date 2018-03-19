library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library six_alpha;
use six_alpha.core_const.all;
use six_alpha.alu_const.all;
use six_alpha.sim_data_types.all;



entity core is
	generic(	sim_en:	boolean := false
				);
	port(	clk:		in  std_logic;
			rst:		in  std_logic;
			
			pin:		in  std_logic_vector(3 downto 0);
			
			paddr:	out  std_logic_vector(3 downto 0);
			pout:		out  std_logic_vector(3 downto 0);
			
			sim:		out  core_sim_data_type
			);
end entity;



architecture behavioral of core is

	component alu is
		port(	op_code:		in  std_logic_vector(2 downto 0);
				operand_a:	in  std_logic_vector(3 downto 0);
				operand_b:	in  std_logic_vector(3 downto 0);
				
				c_flag:		out  std_logic;
				z_flag:		out  std_logic;
				s_flag:		out  std_logic;
				result:		out  std_logic_vector(3 downto 0)
				);
	end component;

	signal alu_op_code:	std_logic_vector(2 downto 0);
	signal alu_c_flag:	std_logic;
	signal alu_z_flag:	std_logic;
	signal alu_s_flag:	std_logic;
	signal alu_result:	std_logic_vector(3 downto 0);
	

	component data_mem is
	generic(	sim_en:	boolean := sim_en
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
	
	signal dm_cf_set:		std_logic;
	signal dm_zf_set:		std_logic;
	signal dm_d_out:		std_logic_vector(3 downto 0);


	component inst_mem is
		port(	clk:		in  std_logic;
				clk_p:	in  std_logic;
		
				addr:		in  std_logic_vector(6 downto 0);
				
				d_out:	out  std_logic_vector(7 downto 0)
				);
	end component;
	
	
	signal clk_phase:		std_logic;
	
	signal a_reg:		std_logic_vector(3 downto 0);
	signal ip_reg:		std_logic_vector(6 downto 0);
	
	signal a_reg_wr_en: 	std_logic;

	signal a_reg_in:		std_logic_vector(3 downto 0);
	signal operand_in:	std_logic_vector(3 downto 0);
	signal inst_word:		std_logic_vector(7 downto 0);
	signal st_inst_dec:	std_logic;
	signal li_inst_dec:	std_logic;
	
	signal sim_sig:	core_sim_data_type;

begin

	alu_0: alu port map(
		op_code =>		alu_op_code,
		operand_a =>	a_reg,
		operand_b =>	operand_in,
		c_flag =>		alu_c_flag,
		z_flag =>		alu_z_flag,
		s_flag =>		alu_s_flag,
		result =>		alu_result
		);

	alu_op_code <=
		'0' & inst_word(3 downto 2) when inst_word(7 downto 4) = BIT_INST_PREF else
		'1' & inst_word(5 downto 4) when inst_word(7 downto 6) = "01"
		else AO_NAND;
		
	operand_in <=	
		inst_word(3 downto 0) when inst_word(7 downto 4) = BIT_INST_PREF or li_inst_dec = '1'
		else dm_d_out;
		
	
	data_mem_0: data_mem port map(
		clk =>		clk,
		clk_p =>		clk_phase,
		rst =>		rst,
		wr_en =>		st_inst_dec,
		alu_cf =>	alu_c_flag,
		alu_zf =>	alu_z_flag,
		cf_set =>	dm_cf_set,
		zf_set =>	dm_zf_set,
		addr =>		inst_word(3 downto 0),
		d_in =>		a_reg,
		d_out =>		dm_d_out,

		pin =>		pin,
		paddr =>		paddr,
		pout =>		pout,
		
		sim =>		sim_sig.dm_sim
		);
		
	st_inst_dec <=	'1' when inst_word(7 downto 4) = ST_INST_PREF
						else '0';
					
	dm_cf_set <= '1' when
		inst_word(7 downto 4) = ADD_INST_PREF or inst_word(7 downto 4) = SUB_INST_PREF
		else '0';
		
	li_inst_dec <=	'1' when inst_word(7 downto 4) = LI_INST_PREF
						else '0';

	dm_zf_set <= '0' when
		inst_word(7) = '1' or inst_word(7 downto 3) = '0' & BIT_INST_PREF or
		li_inst_dec = '1' or st_inst_dec = '1'
		else '1';


	inst_mem_0: inst_mem port map(
		clk =>		clk,
		clk_p =>		clk_phase,
		addr =>		ip_reg,
		d_out =>		inst_word
		);
		

	a_reg_wr_en <= '0' when
		inst_word(7 downto 3) = '0' & BIT_INST_PREF or
		st_inst_dec = '1' or inst_word(7) = '1'
		else '1';
		
	a_reg_in <= operand_in when
		li_inst_dec = '1' or inst_word(7 downto 4) = LD_INST_PREF
		else alu_result;
		
		
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(rst = '1') then
				
				clk_phase <= '0';
				
			else
				
				clk_phase <= not clk_phase;
				
			end if;
		end if;
	end process;
	
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(rst = '1') then
				
				ip_reg <= RST_IP_REG;
				
			elsif(clk_phase = '1') then
				
				if(inst_word(7) = '1') then
					ip_reg <= inst_word(6 downto 0);
				elsif(alu_s_flag = '1') then
					ip_reg <= std_logic_vector(unsigned(ip_reg) + 2);
				else
					ip_reg <= std_logic_vector(unsigned(ip_reg) + 1);
				end if;
				
				if(a_reg_wr_en = '1') then
					a_reg <= a_reg_in;
				end if;
				
			end if;
		end if;
	end process;
	
	
	sim_sig.clk_phase <= clk_phase;
		
	sim_sig.a_reg <= a_reg;
	sim_sig.ip_reg <= ip_reg;
	
	sim_sig.a_reg_wr_en <= a_reg_wr_en;
	
	sim_sig.inst_word <= inst_word;
	
	sim_sig.alu_c_flag <= alu_c_flag;
	sim_sig.alu_z_flag <= alu_z_flag;
	sim_sig.alu_s_flag <= alu_s_flag;
	
	sim_sig.dm_addr <= inst_word(3 downto 0);
	sim_sig.dm_d_out <= dm_d_out;
	
	sim_switch:
	if(sim_en = true) generate
		sim <= sim_sig;
	end generate sim_switch;

end architecture;