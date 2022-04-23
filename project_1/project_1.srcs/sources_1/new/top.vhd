library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is
    port(
        CLK100MHZ     : in  std_logic;
        BTNC  : in  std_logic;
        
        BTNU : in std_logic;
        BTNL : in std_logic;
        BTNR : in std_logic;
        BTND : in std_logic;
   
        SW0 : in std_logic;
        SW1 : in std_logic;
      
        CA : out STD_LOGIC;
        CB : out STD_LOGIC;
        CC : out STD_LOGIC;
        CD : out STD_LOGIC;
        CE : out STD_LOGIC;
        CF : out STD_LOGIC;
        CG : out STD_LOGIC;
   
        AN : out STD_LOGIC_VECTOR(7 downto 0)
   
    );
end entity top;

------------------------------------------------------------
-- Architecture declaration for top
------------------------------------------------------------
architecture Behavioral of top is
    signal s_h0  : std_logic_vector(3 downto 0);
    signal s_h1  : std_logic_vector(3 downto 0);
  
    signal s_m0  : std_logic_vector(3 downto 0);
    signal s_m1  : std_logic_vector(3 downto 0);
    
    signal s_s0  : std_logic_vector(3 downto 0);
    signal s_s1  : std_logic_vector(3 downto 0);
    
    signal BTNU_deb : std_logic;
    signal BTNL_deb : std_logic;
    signal BTNR_deb : std_logic;
    signal BTND_deb : std_logic;

begin
    BTNU_debouncer : entity work.button_debouncer
        port map(
            input => BTNU,
            cclk => CLK100MHZ,
            rst => BTNC,
            output => BTNU_deb
        );
        
    BTNL_debouncer : entity work.button_debouncer
        port map(
            input => BTNL,
            cclk => CLK100MHZ,
            rst => BTNC,
            output => BTNL_deb
        );
        
    BTNR_debouncer : entity work.button_debouncer
        port map(
            input => BTNR,
            cclk => CLK100MHZ,
            rst => BTNC,
            output => BTNR_deb
        );
        
    BTND_debouncer : entity work.button_debouncer
        port map(
            input => BTND,
            cclk => CLK100MHZ,
            rst => BTNC,
            output => BTND_deb
        );


    driver_dig_clock : entity work.driver_dig_clock
        port map(
               clk => CLK100MHZ,
               rst => BTNC,
               
               sw_i => SW0,
               activate_sw_i => SW1,
               btn_1_i => BTNU_deb,
               btn_2_i => BTNL_deb,
               btn_3_i => BTNR_deb,
               btn_4_i => BTND_deb,
                
               h0_o => s_h0,
               h1_o => s_h1,
               
               m0_o => s_m0,
               m1_o => s_m1,
               
               s0_o => s_s0,
               s1_o => s_s1
            );
    
    
    driver_7seg_4digits : entity work.driver_7seg_4digits
            port map(
                clk => CLK100MHZ,
                reset => BTNC,
                
                data_h0_i => s_h0,
                data_h1_i => s_h1,
                
                data_m0_i => s_m0,
                data_m1_i => s_m1,
                
                data_s0_i => s_s0,
                data_s1_i => s_s1,
                
                seg_o(6) => CA,
                seg_o(5) => CB,
                seg_o(4) => CC,
                seg_o(3) => CD,
                seg_o(2) => CE,
                seg_o(1) => CF,
                seg_o(0) => CG,
                
                dig_o(5 downto 0) => AN(5 downto 0)
            );
    AN(7 downto 6) <= b"11";
           
end architecture Behavioral;
