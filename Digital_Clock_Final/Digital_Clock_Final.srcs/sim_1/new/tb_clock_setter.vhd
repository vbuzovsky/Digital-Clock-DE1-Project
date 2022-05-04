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

architecture testbench of tb_clock_setter is
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    signal s_clk_100MHZ : std_logic;
    signal s_en : std_logic;
    signal s_sw : std_logic;
    signal s_btn_1 : std_logic;
    signal s_btn_2 : std_logic;
--    signal s_sec : std_logic_vector(5 downto 0);
    signal s_min : std_logic_vector(5 downto 0);
    signal s_hrs : std_logic_vector(4 downto 0);
begin
    -- Testing driver_dig_clock
    uut_clock_setter: entity work.clock_setter
        port map(
           clk => s_clk_100MHZ,
           en_i => s_en,
           button_1 => s_btn_1,
           button_2 => s_btn_2,
           sw => s_sw,
--           sec_o => s_sec,
           min_o => s_min,
           hr_o => s_hrs
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
    
    p_btn1_press: process
    begin
        s_btn_1 <= '0';
        wait for 130 ns;
        s_btn_1 <= '1';
        wait for 10 ns;
        s_btn_1 <= '0';
        wait for 30 ns;
        s_btn_1 <= '1';
        wait for 10 ns;
        s_btn_1 <= '0';
        wait for 30 ns;
        s_btn_1 <= '1';
        wait for 10 ns;
        s_btn_1 <= '0';
        wait for 30 ns;
        s_btn_1 <= '1';
        wait for 10 ns;
        s_btn_1 <= '0';
        wait for 130 ns;
        s_btn_1 <= '1';
        wait for 10 ns;
        s_btn_1 <= '0';
        wait for 30 ns;
        s_btn_1 <= '1';
        wait for 10 ns;
        s_btn_1 <= '0';
        wait for 30 ns;
        s_btn_1 <= '1';
        wait for 10 ns;
        s_btn_1 <= '0';
        wait for 30 ns;
        s_btn_1 <= '1';
        wait for 10 ns;
        s_btn_1 <= '0';
        wait;
    end process p_btn1_press;
    
    p_btn2_press: process
    begin
        s_btn_2 <= '0';
        wait for 20 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
        wait for 20 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
        wait for 20 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
        wait for 20 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
        wait for 200 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
        wait for 20 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
        wait for 20 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
        wait for 20 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
        wait for 100 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
        wait for 20 ns;
        s_btn_2 <= '1';
        wait for 10 ns;
        s_btn_2 <= '0';
        wait;
    end process p_btn2_press;
    
    p_stimulus : process
    begin
        s_en <= '1';
        report "Stimulus for testing sw <= '1' started" severity note;
        
        s_sw <= '1';wait for 500 ns;
        assert(s_min = "001000")
        report "Error wrong number of minutes" severity error;
        assert(s_hrs = "00111")
        report "Error wrong number of hours" severity error;
        
        report "Stimulus for testing sw <= '1' finished" severity note;
        
        report "Stimulus for testing sw <= '0' started" severity note;
        s_sw <= '0';wait for 500 ns;
        assert(s_min = "001000")
        report "Error wrong number of minutes" severity error;
        assert(s_hrs = "00111")
        report "Error wrong number of hours" severity error;
        
        report "Stimulus for testing sw <= '0' finished" severity note;
        wait;
    end process p_stimulus;
end testbench;