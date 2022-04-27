library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_button_debouncer is

end tb_button_debouncer;

architecture Behavioral of tb_button_debouncer is
    
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    --Local signals - inputs
    signal s_clk_100MHZ : std_logic;
    signal s_rst        : std_logic;
    signal s_btn_1      : std_logic;
    signal s_out        : std_logic;
begin
    -- Testing driver_dig_clock
   uut_button_debouncer : entity work.button_debouncer
        port map(
            cclk => s_clk_100MHZ,
            rst => s_rst,
            input => s_btn_1,
            output => s_out
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
    --RESET GENERATION;
    p_reset_gen : process
    begin
        s_rst <= '0';
        wait for 10 ns;
        s_rst <= '1';
        wait for 10 ns;
        s_rst <= '0';
        wait;
    end process p_reset_gen;
    --BUTTON PRESS
    p_stimulus : process
    begin
        report "Stimulus started" severity note;
        s_btn_1 <= '0';
        wait for 20 ns;
        s_btn_1 <= '1';
        wait for 2 ns;
        s_btn_1 <= '0';
        wait for 5 ns;
        s_btn_1 <= '1';
        wait for 3 ns;
        s_btn_1 <= '0';
        wait for 8 ns;
        s_btn_1 <= '1';
        wait for 100 ns;
        s_btn_1 <= '0';
        wait for 4 ns;
        s_btn_1 <= '1';
        wait for 2 ns;
        s_btn_1 <= '0';
        
    end process p_stimulus;
end Behavioral;