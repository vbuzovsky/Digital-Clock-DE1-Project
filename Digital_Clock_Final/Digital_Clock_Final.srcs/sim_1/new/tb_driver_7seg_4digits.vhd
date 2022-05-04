library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_driver_7seg_4digits is

end tb_driver_7seg_4digits;

architecture testbench of tb_driver_7seg_4digits is
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    
    signal s_clk_100MHZ :std_logic;
    signal s_rst : std_logic;
    signal s_data_h0 : std_logic_vector(3 downto 0);
    signal s_data_h1 : std_logic_vector(3 downto 0);
    signal s_data_m0 : std_logic_vector(3 downto 0);
    signal s_data_m1 : std_logic_vector(3 downto 0);
    signal s_data_s0 : std_logic_vector(3 downto 0);
    signal s_data_s1 : std_logic_vector(3 downto 0);
    signal s_seg     : std_logic_vector(6 downto 0);
    signal s_dig     : std_logic_vector(5 downto 0);
    
    
begin
    -- Testing driver_dig_clock
    uut_driver_7seg_4digits: entity work.driver_7seg_4digits
        port map(
            clk => s_clk_100MHZ,
            reset => s_rst,
            data_h0_i => s_data_h0,
            data_h1_i => s_data_h1,
            data_m0_i => s_data_m0,
            data_m1_i => s_data_m1,
            data_s0_i => s_data_s0,
            data_s1_i => s_data_s1,
            seg_o => s_seg,
            dig_o => s_dig
            
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
        wait for 10 ns;
        s_rst <= '1';
        wait for 25 ns;
        s_rst <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
        report "Stimulus started" severity note;
 
        s_data_h0 <= "0010";
        s_data_h1 <= "0001";
        s_data_m0 <= "0111";
        s_data_m1 <= "0100";
        s_data_s0 <= "0001";
        s_data_s1 <= "0101";
        wait for 400 ns;
        s_data_h0 <= "0000";
        s_data_h1 <= "0010";
        s_data_m0 <= "0101";
        s_data_m1 <= "0001";
        s_data_s0 <= "0010";
        s_data_s1 <= "0010";
        wait for 400 ns;
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end testbench;