library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library six_alpha;
use six_alpha.alu_const.all;



entity alu is
	port(	op_code:		in  std_logic_vector(2 downto 0);
			operand_a:	in  std_logic_vector(3 downto 0);
			operand_b:	in  std_logic_vector(3 downto 0);
			
			c_flag:		out  std_logic;
			z_flag:		out  std_logic;
			s_flag:		out  std_logic;
			result:		out  std_logic_vector(3 downto 0)
			);
end alu;



architecture behavioral of alu is

	signal cf_ext_aux:	std_logic_vector(4 downto 0);
	signal bit_mask:		std_logic_vector(3 downto 0);
	signal result_aux:	std_logic_vector(3 downto 0);
	signal index_bit:		std_logic;

begin

	cf_ext_aux <=
		std_logic_vector(unsigned('0' & operand_a) + unsigned('0' & operand_b)) when op_code = AO_ADD
		else std_logic_vector(unsigned('0' & operand_a) - unsigned('0' & operand_b));

	c_flag <= cf_ext_aux(4);
	
	with operand_b(1 downto 0) select bit_mask <=
		"0001" when "00",
		"0010" when "01",
		"0100" when "10",
		"1000" when others;

	result_aux <=
		operand_a or bit_mask when op_code = AO_SETB else
		operand_a and not bit_mask when op_code = AO_CLRB else
		cf_ext_aux(3 downto 0) when op_code = AO_ADD else
		cf_ext_aux(3 downto 0) when op_code = AO_SUB else
		operand_a xor operand_b when op_code = AO_XOR
		else operand_a nand operand_b;
	
	z_flag <=	'1' when result_aux = "0000"
					else '0';
					
	index_bit <= operand_a(to_integer(unsigned(operand_b(1 downto 0))));

	s_flag <=
		index_bit when op_code = AO_SB else
		not index_bit when op_code = AO_SNB
		else '0';
		
	result <= result_aux;

end behavioral;
