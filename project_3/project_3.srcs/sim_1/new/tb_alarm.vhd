library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_alarm is

end tb_alarm;

architecture testbench of tb_alarm is
    signal s_btn :std_logic;
    signal s_act_sw : std_logic;
    signal s_min : std_logic_vector(5 downto 0);
    signal s_hrs : std_logic_vector(4 downto 0);
    signal s_min_c : std_logic_vector(5 downto 0);
    signal s_hrs_c : std_logic_vector(4 downto 0);
    signal s_ring : std_logic;
    
begin
    -- Testing driver_dig_clock
    uut_alarm: entity work.time_comp_alarm
        port map(
           ring => s_ring,
           activate_sw_i => s_act_sw,
           set_minute => s_min,
           set_hour => s_hrs,
           current_minute => s_min_c,
           current_hour => s_hrs_c,
           button_set => s_btn
        );
    p_btn_press: process
    begin
       s_btn <= '0';
       wait for 50 ns;
       s_btn <= '1';
       wait for 20 ns;

    end process p_btn_press;
    p_stimulus : process
    begin
        report "Stimulus started" severity note;
        s_act_sw <= '1';
        s_min <= "000000";
        s_hrs <= "00000";
        s_min_c <= "000000";
        s_hrs_c <= "00000";
        wait for 200 ns;
        s_act_sw <= '0'; wait for 200 ns;
        s_act_sw <= '1';
        wait for 20 ns;
        s_min_c <= "000001";
        wait for 20 ns;
        s_min_c <= "000010";
        wait for 20 ns;
        s_min_c <= "000011";
        wait for 20 ns;
        s_min_c <= "000100";
        wait for 20 ns;
        s_min_c <= "000101";
        wait for 20 ns;
        s_min_c <= "000000";
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end testbench;