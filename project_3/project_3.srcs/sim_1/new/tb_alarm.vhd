library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_alarm is

end tb_alarm;

architecture Behavioral of tb_alarm is
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    signal s_clk_100MHZ : std_logic;
    signal s_act_sw : std_logic;
    signal s_sec : std_logic_vector(5 downto 0);
    signal s_min : std_logic_vector(5 downto 0);
    signal s_hrs : std_logic_vector(4 downto 0);
    signal s_sec_c : std_logic_vector(5 downto 0);
    signal s_min_c : std_logic_vector(5 downto 0);
    signal s_hrs_c : std_logic_vector(4 downto 0);
    signal s_ring : std_logic;
    
begin
    -- Testing driver_dig_clock
    uut_alarm: entity work.time_comp_alarm
        port map(
           clk => s_clk_100MHZ,
           ring => s_ring,
           act_sw => s_act_sw,
           set_second => s_sec,
           set_minute => s_min,
           set_hour => s_hrs,
           current_second => s_sec_c,
           current_minute => s_min_c,
           current_hour => s_hrs_c
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
    
    p_stimulus : process
    begin
        report "Stimulus started" severity note;
        s_act_sw <= '1';
        s_sec <= "001110";
        s_min <= "000000";
        s_hrs <= "00000";
        s_sec_c <= "000000";
        s_min_c <= "000000";
        s_hrs_c <= "00000";
        wait for 10 ns;
        s_act_sw <= '0';
        wait for 100 ns;
        s_sec_c <= "001110";
        wait for 10 ns;
        wait;
    end process p_stimulus;
end Behavioral;