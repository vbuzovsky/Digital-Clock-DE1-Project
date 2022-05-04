library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_clock_enable is

end tb_clock_enable;

architecture testbench of tb_clock_enable is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    constant c_MAX               : natural := 10;
    
    signal s_clk_100MHZ : std_logic;
    signal s_ce : std_logic;
    signal s_rst : std_logic;

begin
    uut_cnt: entity work.clock_enable
        generic map(
            g_MAX => c_MAX
        )
        port map(
           clk => s_clk_100MHZ,
           ce_o => s_ce,
           reset => s_rst
        );
        
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

    p_reset_gen : process
    begin
        s_rst <= '0'; wait for 30 ns;
        -- Reset activated
        s_rst <= '1'; wait for 100 ns;
        -- Reset deactivated
        s_rst <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end testbench;