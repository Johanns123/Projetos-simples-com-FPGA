library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Contador_Hexadecimal is
	port(
		signal CLK_50 : in std_logic;
		signal RESET  : in std_logic;
		signal KEY	  : in std_logic_vector(3 downto 0);
		signal HEX1, HEX3, HEX2, HEX4	  : out std_logic;
		signal SEG	  : out std_logic_vector(6 downto 0);
		signal LEDY   : out std_logic_vector(3 downto 0)
	);
	
end entity Contador_Hexadecimal;


architecture hardware of Contador_Hexadecimal is

signal contador_led : unsigned (3 downto 0) := (others => '0');
signal led : std_logic_vector (3 downto 0);
signal clk : std_logic;
signal contador1 : unsigned (29 downto 0) := (others => '0');
signal dado : unsigned (3 downto 0) := (others => '0');
signal display : std_logic_vector(6 downto 0);
signal enable : std_logic := '1';


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
HEX1 <= not enable;
HEX2 <= '1';
HEX3 <= '1';
HEX4 <= '1';
SEG <= not display;
led <= std_logic_vector(contador_led);

	TICK : process (clk, RESET) is
	
	begin
		if RESET = '0' then
				contador1 <= (others => '0');
				contador_led <= (others => '0');
				dado <= (others => '0');
				enable <= '0';
		else
			if falling_edge(clk) then
				enable <= '1';
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
	
show_disp1 : conv7_seg port map(enable, std_logic_vector(dado), display);
end architecture hardware;