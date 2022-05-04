library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top is

end tb_top;

architecture testbench of tb_top is
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    
    signal s_clk_100MHZ : std_logic;
    signal s_rst        : std_logic;
    signal s_btn_1       : std_logic;
    signal s_btn_2       : std_logic;
    signal s_btn_3       : std_logic;
    signal s_btn_4       : std_logic;
    
    signal s_sw0        : std_logic;
    signal s_sw1        : std_logic;
    
    signal s_ca         : std_logic;
    signal s_cb         : std_logic;
    signal s_cc         : std_logic;
    signal s_cd         : std_logic;
    signal s_ce         : std_logic;
    signal s_cf         : std_logic;
    signal s_cg         : std_logic;
    
    signal s_led        : std_logic;
    signal s_an         : std_logic_vector(7 downto 0);
    
    
begin
    -- Testing driver_dig_clock
    uut_top: entity work.top
        port map(
            CLK100MHZ => s_clk_100MHZ,
            BTNC => s_rst,
            
            BTNU => s_btn_1,
            BTNL => s_btn_2,
            BTNR => s_btn_3,
            BTND => s_btn_4,
            
            SW0 => s_sw0,
            SW1 => s_sw1,
            
            CA => s_ca,
            CB => s_cb,
            CC => s_cc,
            CD => s_cd,
            CE => s_ce,
            CF => s_cf,
            CG => s_cg,
            
            LED16_B => s_led,
            AN => s_an
            
        );
    --CLOCK GENERATION
    p_clk_gen : process
    begin
        while now < 100000 ns loop -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    --RESET GENERATION
    p_reset_gen : process
    begin
        s_rst <= '0';
        wait for 750 ns;
        s_rst <= '1';
        wait for 30 ns;
        s_rst <= '0';
        wait;
    end process p_reset_gen;
    
    p_btn1_press: process
    begin
        s_btn_1 <= '0';
        wait for 10 ns;
        s_btn_1 <= '1';
        wait for 80 ns;
        s_btn_1 <= '0';
        wait for 20 ns;
        s_btn_1 <= '1';
        wait for 110 ns;
        s_btn_1 <= '0';
        wait for 30 ns;
        s_btn_1 <= '1';
        wait for 30 ns;
        s_btn_1 <= '0';
        wait;
    end process p_btn1_press;
    
    p_btn2_press: process
    begin
        s_btn_2 <= '0';
        wait for 240 ns;
        s_btn_2 <= '1';
        wait for 20 ns;
        s_btn_2 <= '0';
        wait for 20 ns;
        s_btn_2 <= '1';
        wait for 220 ns;
        s_btn_2 <= '0';
        wait;
    end process p_btn2_press;
    
    p_btn3_press: process
    begin
        s_btn_3 <= '0'; wait for 560 ns;
        s_btn_3 <= '1'; wait for 30 ns;
        s_btn_3 <= '0';
        wait;
    end process p_btn3_press;
    
    p_btn4_press: process
    begin
        s_btn_4 <= '0';wait for 650 ns;
        s_btn_4 <= '1'; wait for 30 ns;
        s_btn_4 <= '0';
        wait;
        wait;
    end process p_btn4_press;
    
    p_stimulus : process
    begin
        report "Stimulus started" severity note;
        s_sw1 <= '0';
        s_sw0 <= '0'; wait for 100 ns;
        s_sw0 <= '1'; wait for 450 ns;
        s_sw0 <= '0'; wait for 30 ns;
        s_sw1 <= '1'; wait for 160 ns;
        s_sw1 <= '0';
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end testbench;