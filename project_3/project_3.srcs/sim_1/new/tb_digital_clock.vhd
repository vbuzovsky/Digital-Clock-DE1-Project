library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_digital_clock is

end tb_digital_clock;

architecture testbench of tb_digital_clock is
    constant c_CLK_100MHZ_PERIOD : time := 1 ns;
    
    signal s_clk_100MHZ : std_logic;
    signal s_rst : std_logic;
    signal s_en : std_logic;
    
    signal s_btn :std_logic;
    signal s_sec_set : std_logic_vector(5 downto 0);
    signal s_min_set : std_logic_vector(5 downto 0);
    signal s_hrs_set : std_logic_vector(4 downto 0);
    
    signal s_sec : std_logic_vector(5 downto 0);
    signal s_min : std_logic_vector(5 downto 0);
    signal s_hrs : std_logic_vector(4 downto 0);
    
begin
    uut_digital_clock: entity work.digital_clock
        port map(
           clk => s_clk_100MHZ,
           en_i => s_en,
           rst => s_rst,
           
           set_second => s_sec_set,
           set_minute => s_min_set,
           set_hour => s_hrs_set,
           
           sec_o => s_sec,
           min_o => s_min,
           hr_o => s_hrs,
           btn_set => s_btn
        );
    p_clk_gen : process
    begin
        while now < 1000 ns loop -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_reset_gen : process
    begin
        s_rst <= '0'; wait for 200 ns;
        -- Reset activated
        s_rst <= '1'; wait for 100 ns;
        -- Reset deactivated
        s_rst <= '0';
        wait;
    end process p_reset_gen;
    
    p_btn_press: process
    begin
       s_btn <= '0';
       wait for 500 ns;
       s_btn <= '1';
       wait for 20 ns;
       s_btn <= '0';
       wait;
    end process p_btn_press;
    p_stimulus : process
    begin
        report "Stimulus started" severity note;
        s_en <= '1';
        s_sec_set <= "000000";
        s_min_set <= "111001";
        s_hrs_set <= "00111";
        wait for 505 ns; --wait until button press
        
        assert(s_sec = "000000" and s_min = "111001" and s_hrs = "00111")
        report "Error while setting numbers" severity error;
        
        wait for 300 ns;
        s_en <= '0';
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end testbench;