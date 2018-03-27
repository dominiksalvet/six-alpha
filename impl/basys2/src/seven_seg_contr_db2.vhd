library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity seven_seg_contr_db2 is
	generic(	clk_div:		natural
				);
	port(	clk:			in  std_logic;
			
			data_in:		in  std_logic_vector(15 downto 0);
			
			seg_sel:		out  std_logic_vector(3 downto 0);
			seg_data:	out  std_logic_vector(7 downto 0)
			);
end seven_seg_contr_db2;



architecture behavioral of seven_seg_contr_db2 is

	constant DIGIT_0:		std_logic_vector(6 downto 0) := "0000001";
	constant DIGIT_1:		std_logic_vector(6 downto 0) := "1001111";
	constant DIGIT_2:		std_logic_vector(6 downto 0) := "0010010";
	constant DIGIT_3:		std_logic_vector(6 downto 0) := "0000110";
	constant DIGIT_4:		std_logic_vector(6 downto 0) := "1001100";
	constant DIGIT_5:		std_logic_vector(6 downto 0) := "0100100";
	constant DIGIT_6:		std_logic_vector(6 downto 0) := "0100000";
	constant DIGIT_7:		std_logic_vector(6 downto 0) := "0001111";
	constant DIGIT_8:		std_logic_vector(6 downto 0) := "0000000";
	constant DIGIT_9:		std_logic_vector(6 downto 0) := "0000100";
	constant DIGIT_A:		std_logic_vector(6 downto 0) := "0001000";
	constant DIGIT_B:		std_logic_vector(6 downto 0) := "1100000";
	constant DIGIT_C:		std_logic_vector(6 downto 0) := "0110001";
	constant DIGIT_D:		std_logic_vector(6 downto 0) := "1000010";
	constant DIGIT_E:		std_logic_vector(6 downto 0) := "0110000";
	constant DIGIT_F:		std_logic_vector(6 downto 0) := "0111000";
	
	constant SEG_PHASE_0:	std_logic_vector(3 downto 0) := "1110";
	constant SEG_PHASE_1:	std_logic_vector(3 downto 0) := "1101";
	constant SEG_PHASE_2:	std_logic_vector(3 downto 0) := "1011";
	constant SEG_PHASE_3:	std_logic_vector(3 downto 0) := "0111";


	signal seg_phase:			std_logic_vector(3 downto 0) := SEG_PHASE_0;
	signal dig_seg_data:		std_logic_vector(6 downto 0);
	
	signal dig_bin_data:		std_logic_vector(3 downto 0);
	
	signal clk_count:		natural := 0;

begin

	seg_sel <= seg_phase;
	
	seg_data <= dig_seg_data & '1';
	
	with seg_phase select dig_bin_data <=
		data_in(3 downto 0) when SEG_PHASE_0,
		data_in(7 downto 4) when SEG_PHASE_1,
		data_in(11 downto 8) when SEG_PHASE_2,
		data_in(15 downto 12) when others;
	
	with dig_bin_data select dig_seg_data <=
		DIGIT_0 when "0000",
		DIGIT_1 when "0001",
		DIGIT_2 when "0010",
		DIGIT_3 when "0011",
		DIGIT_4 when "0100",
		DIGIT_5 when "0101",
		DIGIT_6 when "0110",
		DIGIT_7 when "0111",
		DIGIT_8 when "1000",
		DIGIT_9 when "1001",
		DIGIT_A when "1010",
		DIGIT_B when "1011",
		DIGIT_C when "1100",
		DIGIT_D when "1101",
		DIGIT_E when "1110",
		DIGIT_F when others;
		
		
	process(clk)
	begin
		if(rising_edge(clk)) then
		
			if(clk_count = clk_div) then
				
				clk_count <= 0;
				
				case seg_phase is
					when SEG_PHASE_0 => seg_phase <= SEG_PHASE_1;
					when SEG_PHASE_1 => seg_phase <= SEG_PHASE_2;
					when SEG_PHASE_2 => seg_phase <= SEG_PHASE_3;
					when others => seg_phase <= SEG_PHASE_0;
				end case;
				
			else
				
				clk_count <= clk_count + 1;
				
			end if;
				
		end if;
	end process;

end behavioral;