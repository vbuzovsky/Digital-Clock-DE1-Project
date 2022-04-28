library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_cnt_up_down is

end tb_cnt_up_down;

architecture testbench of tb_cnt_up_down is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    constant c_CNT_WIDTH         : natural := 4;
    
    signal s_clk_100MHZ : std_logic;
    signal s_en : std_logic;
    signal s_rst : std_logic;
    signal s_cnt_up : std_logic;
    signal s_cnt    : std_logic_vector(c_CNT_WIDTH - 1 downto 0);
begin
    -- Testing driver_dig_clock
    uut_cnt: entity work.cnt_up_down_2
        port map(
           clk => s_clk_100MHZ,
           en_i => s_en,
           reset => s_rst,
           cnt_up_i => s_cnt_up,
           cnt_o => s_cnt
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
        s_rst <= '0'; wait for 20 ns;
        -- Reset activated
        s_rst <= '1'; wait for 60 ns;
        -- Reset deactivated
        s_rst <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
         report "Stimulus process started" severity note;

        -- Enable counting
        s_en     <= '1';
        
        -- Change counter direction
        s_cnt_up <= '1';
        wait for 380 ns;
        s_cnt_up <= '0';
        wait for 220 ns;

        -- Disable counting
        s_en     <= '0';

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end testbench;