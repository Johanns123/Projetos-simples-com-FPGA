library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Contador_Decimal_e_hexadecimal is
	port(
		signal CLK_50 : in std_logic;
		signal RESET  : in std_logic;
		signal KEY	  : in std_logic_vector(3 downto 0);
		signal HEX1, HEX3, HEX2, HEX4	  : out std_logic;
		signal SEG	  : out std_logic_vector(6 downto 0);
		signal LEDY   : out std_logic_vector(3 downto 0)
	);
	
end entity Contador_Decimal_e_hexadecimal;


architecture hardware of Contador_Decimal_e_hexadecimal is

signal mode : std_logic;
signal contador_led : unsigned (3 downto 0) := (others => '0');
signal led : std_logic_vector (3 downto 0);
signal clk : std_logic;
signal contador1, contador2 : unsigned (29 downto 0) := (others => '0');
signal dado : unsigned (3 downto 0) := (others => '0');
signal dado_reverso : unsigned (3 downto 0) := (others => '0');
signal unidade_dado : unsigned (3 downto 0) := (others => '0');
signal dezena_dado : unsigned (3 downto 0) := (others => '0');
signal display : std_logic_vector(6 downto 0);
signal display_dec_unidade, display_dec_dezena, display_hex, display3_hex_reverse : std_logic_vector(6 downto 0);
signal enable1 : std_logic := '1';
signal enable2 : std_logic := '1';
signal enable3 : std_logic := '1';

type state is (disp1, disp2, disp3);

signal display_mux : state := disp1;

component Conv7_seg is
	port(
		signal enable	  	: in std_logic;
		signal dado			: in std_logic_vector(3 downto 0);
		signal display	  		: out std_logic_vector(6 downto 0)
	);
	
end component Conv7_seg;

begin
		
LEDY(0) <= not led(3);
LEDY(1) <= not led(2);
LEDY(2) <= not led(1);
LEDY(3) <= not led(0);
clk  <= CLK_50;
HEX1 <= not enable1;
HEX2 <= not enable2;
HEX3 <= not enable3;
HEX4 <= '1';
SEG <= not display;
led <= std_logic_vector(contador_led);
dado_reverso <= not dado;

	MUX  : process(clk, RESET) is
	begin
		if RESET = '0' then
			contador2 <= (others => '0');
			enable1 <= '0';
			enable2 <= '0';
			enable3 <= '0';
		else
			if falling_edge(clk) then
				if(contador2 < 49999) then
					contador2 <= contador2 + 1;
				else
					contador2 <= (others => '0');
					case display_mux is
						when disp1 =>
							enable1 <= '1';
							enable2 <= '0';
							enable3 <= '0';
							if mode = '1' then display_mux <= disp3;
							else	display_mux <= disp2; end if;
						
						when disp2 =>
							enable2 <= '1';
							enable1 <= '0';
							enable3 <= '0';
							display_mux <= disp3;
						
						when disp3 =>
							enable1 <= '0';
							enable2 <= '0';
							enable3 <= '1';
							display_mux <= disp1;
					end case;
				end if;
			end if;
		end if;
	end process MUX;
	
	TICK : process (clk, RESET) is
	
	begin
		if RESET = '0' then
				contador1 <= (others => '0');
				contador_led <= (others => '0');
				dado <= (others => '0');
		else
			if falling_edge(clk) then
				if(contador1 < 49999999) then
					contador1 <= contador1 + 1;
				else
					contador1 <= (others => '0');
					contador_led <= contador_led + 1;
					dado <= dado + 1;
				end if;
			end if;
		end if;
	end process TICK;
	
	PUSH_BUTTON : process(KEY(3)) is
	
	begin
		if falling_edge(KEY(3)) then
			mode <= not mode;
		end if;
	end process PUSH_BUTTON;
	
	with dado select 
	unidade_dado <= 
	"0000" when "0000",
	"0001" when "0001",
	"0010" when "0010",
	"0011" when "0011",
	"0100" when "0100",
	"0101" when "0101",
	"0110" when "0110",
	"0111" when "0111",
	"1000" when "1000",
	"1001" when "1001",
	"0000" when "1010",
	"0001" when "1011",
	"0010" when "1100",
	"0011" when "1101",
	"0100" when "1110",
	"0101" when "1111";
	
	with dado select
	dezena_dado <=
	"0000" when "0000",
	"0000" when "0001",
	"0000" when "0010",
	"0000" when "0011",
	"0000" when "0100",
	"0000" when "0101",
	"0000" when "0110",
	"0000" when "0111",
	"0000" when "1000",
	"0000" when "1001",
	"0001" when others;
	
	
	display <= display_dec_unidade  when enable1 = '1' and mode = '0' else
				  display_dec_dezena  when enable2 = '1' and mode = '0' else
				  display_hex 			  when enable1 = '1' and mode = '1' else
				  display3_hex_reverse when enable3 = '1';
				  
show_disp_dec_unidade : conv7_seg port map(enable1, std_logic_vector(unidade_dado), display_dec_unidade);
show_disp_dec_dezena  : conv7_seg port map(enable2, std_logic_vector(dezena_dado), display_dec_dezena);
show_dispHex 			 : conv7_seg port map(enable1, std_logic_vector(dado), display_hex);
show_disp_reverseHex  : conv7_seg port map(enable3, std_logic_vector(dado_reverso), display3_hex_reverse);
end architecture hardware;