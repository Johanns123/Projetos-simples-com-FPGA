-- jsjcca_qsys_led_yellow_s1_translator.vhd

-- Generated using ACDS version 13.0sp1 232 at 2023.02.09.01:16:07

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity jsjcca_qsys_led_yellow_s1_translator is
	generic (
		AV_ADDRESS_W                   : integer := 2;
		AV_DATA_W                      : integer := 32;
		UAV_DATA_W                     : integer := 32;
		AV_BURSTCOUNT_W                : integer := 1;
		AV_BYTEENABLE_W                : integer := 1;
		UAV_BYTEENABLE_W               : integer := 4;
		UAV_ADDRESS_W                  : integer := 18;
		UAV_BURSTCOUNT_W               : integer := 3;
		AV_READLATENCY                 : integer := 0;
		USE_READDATAVALID              : integer := 0;
		USE_WAITREQUEST                : integer := 0;
		USE_UAV_CLKEN                  : integer := 0;
		USE_READRESPONSE               : integer := 0;
		USE_WRITERESPONSE              : integer := 0;
		AV_SYMBOLS_PER_WORD            : integer := 4;
		AV_ADDRESS_SYMBOLS             : integer := 0;
		AV_BURSTCOUNT_SYMBOLS          : integer := 0;
		AV_CONSTANT_BURST_BEHAVIOR     : integer := 0;
		UAV_CONSTANT_BURST_BEHAVIOR    : integer := 0;
		AV_REQUIRE_UNALIGNED_ADDRESSES : integer := 0;
		CHIPSELECT_THROUGH_READLATENCY : integer := 0;
		AV_READ_WAIT_CYCLES            : integer := 1;
		AV_WRITE_WAIT_CYCLES           : integer := 0;
		AV_SETUP_WAIT_CYCLES           : integer := 0;
		AV_DATA_HOLD_CYCLES            : integer := 0
	);
	port (
		clk                      : in  std_logic                     := '0';             --                      clk.clk
		reset                    : in  std_logic                     := '0';             --                    reset.reset
		uav_address              : in  std_logic_vector(17 downto 0) := (others => '0'); -- avalon_universal_slave_0.address
		uav_burstcount           : in  std_logic_vector(2 downto 0)  := (others => '0'); --                         .burstcount
		uav_read                 : in  std_logic                     := '0';             --                         .read
		uav_write                : in  std_logic                     := '0';             --                         .write
		uav_waitrequest          : out std_logic;                                        --                         .waitrequest
		uav_readdatavalid        : out std_logic;                                        --                         .readdatavalid
		uav_byteenable           : in  std_logic_vector(3 downto 0)  := (others => '0'); --                         .byteenable
		uav_readdata             : out std_logic_vector(31 downto 0);                    --                         .readdata
		uav_writedata            : in  std_logic_vector(31 downto 0) := (others => '0'); --                         .writedata
		uav_lock                 : in  std_logic                     := '0';             --                         .lock
		uav_debugaccess          : in  std_logic                     := '0';             --                         .debugaccess
		av_address               : out std_logic_vector(1 downto 0);                     --      avalon_anti_slave_0.address
		av_write                 : out std_logic;                                        --                         .write
		av_readdata              : in  std_logic_vector(31 downto 0) := (others => '0'); --                         .readdata
		av_writedata             : out std_logic_vector(31 downto 0);                    --                         .writedata
		av_chipselect            : out std_logic;                                        --                         .chipselect
		av_beginbursttransfer    : out std_logic;
		av_begintransfer         : out std_logic;
		av_burstcount            : out std_logic_vector(0 downto 0);
		av_byteenable            : out std_logic_vector(0 downto 0);
		av_clken                 : out std_logic;
		av_debugaccess           : out std_logic;
		av_lock                  : out std_logic;
		av_outputenable          : out std_logic;
		av_read                  : out std_logic;
		av_readdatavalid         : in  std_logic                     := '0';
		av_response              : in  std_logic_vector(1 downto 0)  := (others => '0');
		av_waitrequest           : in  std_logic                     := '0';
		av_writebyteenable       : out std_logic_vector(0 downto 0);
		av_writeresponserequest  : out std_logic;
		av_writeresponsevalid    : in  std_logic                     := '0';
		uav_clken                : in  std_logic                     := '0';
		uav_response             : out std_logic_vector(1 downto 0);
		uav_writeresponserequest : in  std_logic                     := '0';
		uav_writeresponsevalid   : out std_logic
	);
end entity jsjcca_qsys_led_yellow_s1_translator;

architecture rtl of jsjcca_qsys_led_yellow_s1_translator is
	component altera_merlin_slave_translator is
		generic (
			AV_ADDRESS_W                   : integer := 30;
			AV_DATA_W                      : integer := 32;
			UAV_DATA_W                     : integer := 32;
			AV_BURSTCOUNT_W                : integer := 4;
			AV_BYTEENABLE_W                : integer := 4;
			UAV_BYTEENABLE_W               : integer := 4;
			UAV_ADDRESS_W                  : integer := 32;
			UAV_BURSTCOUNT_W               : integer := 4;
			AV_READLATENCY                 : integer := 0;
			USE_READDATAVALID              : integer := 1;
			USE_WAITREQUEST                : integer := 1;
			USE_UAV_CLKEN                  : integer := 0;
			USE_READRESPONSE               : integer := 0;
			USE_WRITERESPONSE              : integer := 0;
			AV_SYMBOLS_PER_WORD            : integer := 4;
			AV_ADDRESS_SYMBOLS             : integer := 0;
			AV_BURSTCOUNT_SYMBOLS          : integer := 0;
			AV_CONSTANT_BURST_BEHAVIOR     : integer := 0;
			UAV_CONSTANT_BURST_BEHAVIOR    : integer := 0;
			AV_REQUIRE_UNALIGNED_ADDRESSES : integer := 0;
			CHIPSELECT_THROUGH_READLATENCY : integer := 0;
			AV_READ_WAIT_CYCLES            : integer := 0;
			AV_WRITE_WAIT_CYCLES           : integer := 0;
			AV_SETUP_WAIT_CYCLES           : integer := 0;
			AV_DATA_HOLD_CYCLES            : integer := 0
		);
		port (
			clk                      : in  std_logic                     := 'X';             -- clk
			reset                    : in  std_logic                     := 'X';             -- reset
			uav_address              : in  std_logic_vector(17 downto 0) := (others => 'X'); -- address
			uav_burstcount           : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- burstcount
			uav_read                 : in  std_logic                     := 'X';             -- read
			uav_write                : in  std_logic                     := 'X';             -- write
			uav_waitrequest          : out std_logic;                                        -- waitrequest
			uav_readdatavalid        : out std_logic;                                        -- readdatavalid
			uav_byteenable           : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			uav_readdata             : out std_logic_vector(31 downto 0);                    -- readdata
			uav_writedata            : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			uav_lock                 : in  std_logic                     := 'X';             -- lock
			uav_debugaccess          : in  std_logic                     := 'X';             -- debugaccess
			av_address               : out std_logic_vector(1 downto 0);                     -- address
			av_write                 : out std_logic;                                        -- write
			av_readdata              : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			av_writedata             : out std_logic_vector(31 downto 0);                    -- writedata
			av_chipselect            : out std_logic;                                        -- chipselect
			av_read                  : out std_logic;                                        -- read
			av_begintransfer         : out std_logic;                                        -- begintransfer
			av_beginbursttransfer    : out std_logic;                                        -- beginbursttransfer
			av_burstcount            : out std_logic_vector(0 downto 0);                     -- burstcount
			av_byteenable            : out std_logic_vector(0 downto 0);                     -- byteenable
			av_readdatavalid         : in  std_logic                     := 'X';             -- readdatavalid
			av_waitrequest           : in  std_logic                     := 'X';             -- waitrequest
			av_writebyteenable       : out std_logic_vector(0 downto 0);                     -- writebyteenable
			av_lock                  : out std_logic;                                        -- lock
			av_clken                 : out std_logic;                                        -- clken
			uav_clken                : in  std_logic                     := 'X';             -- clken
			av_debugaccess           : out std_logic;                                        -- debugaccess
			av_outputenable          : out std_logic;                                        -- outputenable
			uav_response             : out std_logic_vector(1 downto 0);                     -- response
			av_response              : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- response
			uav_writeresponserequest : in  std_logic                     := 'X';             -- writeresponserequest
			uav_writeresponsevalid   : out std_logic;                                        -- writeresponsevalid
			av_writeresponserequest  : out std_logic;                                        -- writeresponserequest
			av_writeresponsevalid    : in  std_logic                     := 'X'              -- writeresponsevalid
		);
	end component altera_merlin_slave_translator;

begin

	led_yellow_s1_translator : component altera_merlin_slave_translator
		generic map (
			AV_ADDRESS_W                   => AV_ADDRESS_W,
			AV_DATA_W                      => AV_DATA_W,
			UAV_DATA_W                     => UAV_DATA_W,
			AV_BURSTCOUNT_W                => AV_BURSTCOUNT_W,
			AV_BYTEENABLE_W                => AV_BYTEENABLE_W,
			UAV_BYTEENABLE_W               => UAV_BYTEENABLE_W,
			UAV_ADDRESS_W                  => UAV_ADDRESS_W,
			UAV_BURSTCOUNT_W               => UAV_BURSTCOUNT_W,
			AV_READLATENCY                 => AV_READLATENCY,
			USE_READDATAVALID              => USE_READDATAVALID,
			USE_WAITREQUEST                => USE_WAITREQUEST,
			USE_UAV_CLKEN                  => USE_UAV_CLKEN,
			USE_READRESPONSE               => USE_READRESPONSE,
			USE_WRITERESPONSE              => USE_WRITERESPONSE,
			AV_SYMBOLS_PER_WORD            => AV_SYMBOLS_PER_WORD,
			AV_ADDRESS_SYMBOLS             => AV_ADDRESS_SYMBOLS,
			AV_BURSTCOUNT_SYMBOLS          => AV_BURSTCOUNT_SYMBOLS,
			AV_CONSTANT_BURST_BEHAVIOR     => AV_CONSTANT_BURST_BEHAVIOR,
			UAV_CONSTANT_BURST_BEHAVIOR    => UAV_CONSTANT_BURST_BEHAVIOR,
			AV_REQUIRE_UNALIGNED_ADDRESSES => AV_REQUIRE_UNALIGNED_ADDRESSES,
			CHIPSELECT_THROUGH_READLATENCY => CHIPSELECT_THROUGH_READLATENCY,
			AV_READ_WAIT_CYCLES            => AV_READ_WAIT_CYCLES,
			AV_WRITE_WAIT_CYCLES           => AV_WRITE_WAIT_CYCLES,
			AV_SETUP_WAIT_CYCLES           => AV_SETUP_WAIT_CYCLES,
			AV_DATA_HOLD_CYCLES            => AV_DATA_HOLD_CYCLES
		)
		port map (
			clk                      => clk,               --                      clk.clk
			reset                    => reset,             --                    reset.reset
			uav_address              => uav_address,       -- avalon_universal_slave_0.address
			uav_burstcount           => uav_burstcount,    --                         .burstcount
			uav_read                 => uav_read,          --                         .read
			uav_write                => uav_write,         --                         .write
			uav_waitrequest          => uav_waitrequest,   --                         .waitrequest
			uav_readdatavalid        => uav_readdatavalid, --                         .readdatavalid
			uav_byteenable           => uav_byteenable,    --                         .byteenable
			uav_readdata             => uav_readdata,      --                         .readdata
			uav_writedata            => uav_writedata,     --                         .writedata
			uav_lock                 => uav_lock,          --                         .lock
			uav_debugaccess          => uav_debugaccess,   --                         .debugaccess
			av_address               => av_address,        --      avalon_anti_slave_0.address
			av_write                 => av_write,          --                         .write
			av_readdata              => av_readdata,       --                         .readdata
			av_writedata             => av_writedata,      --                         .writedata
			av_chipselect            => av_chipselect,     --                         .chipselect
			av_read                  => open,              --              (terminated)
			av_begintransfer         => open,              --              (terminated)
			av_beginbursttransfer    => open,              --              (terminated)
			av_burstcount            => open,              --              (terminated)
			av_byteenable            => open,              --              (terminated)
			av_readdatavalid         => '0',               --              (terminated)
			av_waitrequest           => '0',               --              (terminated)
			av_writebyteenable       => open,              --              (terminated)
			av_lock                  => open,              --              (terminated)
			av_clken                 => open,              --              (terminated)
			uav_clken                => '0',               --              (terminated)
			av_debugaccess           => open,              --              (terminated)
			av_outputenable          => open,              --              (terminated)
			uav_response             => open,              --              (terminated)
			av_response              => "00",              --              (terminated)
			uav_writeresponserequest => '0',               --              (terminated)
			uav_writeresponsevalid   => open,              --              (terminated)
			av_writeresponserequest  => open,              --              (terminated)
			av_writeresponsevalid    => '0'                --              (terminated)
		);

end architecture rtl; -- of jsjcca_qsys_led_yellow_s1_translator
