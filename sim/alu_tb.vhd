library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library six_alpha;
use six_alpha.alu_const.all;



entity alu_tb is
end alu_tb;



architecture behavioral of alu_tb is

	component alu
		port(	op_code:		in  std_logic_vector(2 downto 0);
				operand_a:	in  std_logic_vector(3 downto 0);
				operand_b:	in  std_logic_vector(3 downto 0);
				
				c_flag:		out  std_logic;
				z_flag:		out  std_logic;
				s_flag:		out  std_logic;
				result:		out  std_logic_vector(3 downto 0)
				);
	end component;

	signal op_code:		std_logic_vector(2 downto 0) := (others => '0');
	signal operand_a:		std_logic_vector(3 downto 0) := (others => '0');
	signal operand_b:		std_logic_vector(3 downto 0) := (others => '0');

	signal c_flag:		std_logic;
	signal z_flag:		std_logic;
	signal s_flag:		std_logic;
	signal result:		std_logic_vector(3 downto 0);

begin
	
	uut: alu port map(
	op_code =>		op_code,
	operand_a =>	operand_a,
	operand_b =>	operand_b,
	c_flag =>		c_flag,
	z_flag =>		z_flag,
	s_flag =>		s_flag,
	result =>		result
	);


	stim_proc: process
	begin
		
		op_code <= AO_NAND;
		operand_a <= "1010";
		operand_b <= "0101";
		wait for 10 ns;
		
		op_code <= AO_ADD;
		operand_a <= std_logic_vector(to_unsigned(7 ,operand_a'length));
		operand_b <= std_logic_vector(to_unsigned(6 ,operand_b'length));
		wait for 10 ns;
		
		operand_a <= std_logic_vector(to_unsigned(10 ,operand_a'length));
		wait for 10 ns;
		
		op_code <= AO_SUB;
		wait for 10 ns;
		
		op_code <= AO_CLRB;
		operand_a <= "0100";
		operand_b <= "00" & std_logic_vector(to_unsigned(2 ,operand_a'length / 2));
		wait for 10 ns;
		
		op_code <= AO_SB;
		wait;
		
	end process;

end behavioral;