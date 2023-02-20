library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity HelloWorld_from_Nios_II is
	port(
		signal CLK_50 : in std_logic;
		signal RESET  : in std_logic;
		signal KEY	  : in std_logic_vector(3 downto 0);
		signal LEDY   : out std_logic_vector(3 downto 0)
	);
	
end entity HelloWorld_from_Nios_II;


architecture hardware of HelloWorld_from_Nios_II is

signal led : std_logic_vector (3 downto 0);
signal clk : std_logic;

component JSJCCA_QSYS is
		port (
			clk_clk                               : in  std_logic                    := 'X';             -- clk
			reset_reset_n                         : in  std_logic                    := 'X';             -- reset_n
			key_external_connection_export        : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			led_yellow_external_connection_export : out std_logic_vector(3 downto 0)                     -- export
		);
end component JSJCCA_QSYS;


begin
		
LEDY(0) <= not led(3);
LEDY(1) <= not led(2);
LEDY(2) <= not led(1);
LEDY(3) <= not led(0);
clk  <= CLK_50;

Processor : JSJCCA_QSYS port map(clk, RESET, KEY, led);
end architecture hardware;