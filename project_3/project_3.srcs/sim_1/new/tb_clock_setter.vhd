library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_clock_setter is

end tb_clock_setter;

architecture Behavioral of tb_clock_setter is
    signal s_sw : std_logic;
    signal s_btn_1 : std_logic;
    signal s_btn_2 : std_logic;
    signal s_btn_3 : std_logic;
    signal s_sec : std_logic_vector(5 downto 0);
    signal s_min : std_logic_vector(5 downto 0);
    signal s_hrs : std_logic_vector(4 downto 0);
begin
    -- Testing driver_dig_clock
    uut_clock_setter: entity work.clock_setter
        port map(
           button_1 => s_btn_1,
           button_2 => s_btn_2,
           button_3 => s_btn_3,
           sw => s_sw,
           sec_o => s_sec,
           min_o => s_min,
           hr_o => s_hrs
        );
    p_btn1_press: process
    begin
        s_btn_1 <= '0';
        wait for 120 ns;
        s_btn_1 <= '1';
        wait for 10 ns;
        s_btn_1 <= '0';
    end process p_btn1_press;
    p_btn2_press: process
    begin
        s_btn_2 <= '0';
        wait for 100 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
    end process p_btn2_press;
    p_stimulus : process
    begin
        report "Stimulus started" severity note;
        s_sw <= '1';
        wait;
    end process p_stimulus;
end Behavioral;