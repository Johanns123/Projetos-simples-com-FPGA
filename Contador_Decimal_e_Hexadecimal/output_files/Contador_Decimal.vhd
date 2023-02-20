library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Contador_Decimal is
	port(
		signal CLK_50 							  : in std_logic;
		signal RESET  							  : in std_logic;
		signal HEX_dezena, HEX_unidade	  : out std_logic;
		signal SEG	  							  : out std_logic_vector(6 downto 0);
	);
	
end entity Contador_Decimal;


architecture hardware of Contador is

signal clk : std_logic;
signal contador : unsigned (29 downto 0) := (others => '0');
signal dado : unsigned (3 downto 0) := (others => '0');
signal unidade_dado : unsigned (3 downto 0) := (others => '0');
signal dezena_dado : unsigned (3 downto 0) := (others => '0');
signal display : std_logic_vector(6 downto 0);
signal display1, display2 : std_logic_vector(6 downto 0);

type state is (disp1, disp2);

signal display_mux : state := disp1;

component Conv7_seg is
	port(
		signal enable	  	: in std_logic;
		signal dado			: in std_logic_vector(3 downto 0);
		signal display	  		: out std_logic_vector(6 downto 0)
	);
	
end component Conv7_seg;


begin
		
clk  <= CLK_50;
SEG <= display;

	MUX  : process(clk, RESET) is
	begin
		if RESET = '0' then
			contador2 <= (others => '0');
			enable1 <= '0';
			enable2 <= '0';
		else
			if falling_edge(clk) then
				if(contador < 49999) then
					contador <= contador + 1;
				else
					contador <= (others => '0');
					case display_mux is
						when disp1 =>
							enable1 <= '1';
							enable2 <= '0';
							display_mux <= disp2;
						when disp2 =>
							enable2 <= '1';
							enable1 <= '0';
							display_mux <= disp1;
					end case;
				end if;
			end if;
		end if;
	end process MUX;
	
	
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
	
	
	display <= display1 when enable1 = '1' else
				  display2 when enable2 = '1' else
				  display3 when enable3 = '1';
				  
show_disp1 : conv7_seg port map(enable1, std_logic_vector(unidade_dado), display1);
show_disp2 : conv7_seg port map(enable2, std_logic_vector(dezena_dado), display2);
contagem_hex : contador_Hexadecimal port map(CLK_50, RESET, enable3, display3);
end architecture hardware;