library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Projeto_cont_disp is
	port(
		signal CLK_50 : in std_logic;
		signal RESET  : in std_logic;
		signal KEY	  : in std_logic_vector(3 downto 0);
		signal HEX1, HEX3, HEX2, HEX4	  : out std_logic;
		signal SEG	  : out std_logic_vector(6 downto 0)
	);
	
end entity Projeto_cont_disp;


architecture hardware of Projeto_cont_disp is

signal clk : std_logic;
signal display1, display2, display3, display4 : std_logic;
signal Tseg 			: std_logic_vector(6 downto 0);
signal dado_reg   	: unsigned (3 downto 0);
signal modo_reg		: unsigned (1 downto 0);
signal local_reg	   : unsigned (1 downto 0);
signal contador		: unsigned (29 downto 0);

component Controlador_display_paralelo is
	port(
		signal clk 		: in std_logic;
		signal key		: in std_logic;
		signal RESET   : in std_logic;
		signal dado    : in unsigned (3 downto 0);
		signal modo		: in unsigned (1 downto 0);
		signal local   : in unsigned (1 downto 0);
		signal HEX1, HEX3, HEX2, HEX4	  : out std_logic;
		signal SEG	  : out std_logic_vector(6 downto 0)
	);
	
end component Controlador_display_paralelo;


begin
	
	clk <= CLK_50;
	
	HEX1 <= not display1;
	HEX2 <= not display2;
	HEX3 <= not display3;
	HEX4 <= not display4;
	SEG <= not Tseg;
	
	--modo <= "11";
	--dado <= X"2";
	--local <= "01";
	
	TICK : process (clk, RESET) is
	
	begin
		if RESET = '0' then
				contador <= (others => '0');
				dado_reg <= X"0";
				local_reg <= "00";
				modo_reg <= "00";
		else
			if falling_edge(clk) then
				if(contador < 49999999) then
					contador <= contador + 1;
				else
					dado_reg <= dado_reg + 1;
					local_reg <= local_reg + 1;
					modo_reg <= modo_reg + 1;
					contador <= (others => '0');
				end if;
			end if;
		end if;
	end process TICK;
	
cont_disp : controlador_display_paralelo port map(clk, KEY(3), RESET, dado_reg, modo_reg, local_reg,
				display1, display2, display3, display4, Tseg);	
end architecture hardware;