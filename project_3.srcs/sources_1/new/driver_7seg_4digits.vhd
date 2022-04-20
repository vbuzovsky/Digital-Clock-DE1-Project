------------------------------------------------------------
--
-- Driver for 4-digit 7-segment display.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for display driver
--
--             +------------------+
--        -----|> clk             |
--        -----| reset       dp_o |-----
--             |       seg_o(6:0) |--/--
--        --/--| data0_i(3:0)     |  7
--        --/--| data1_i(3:0)     |
--        --/--| data2_i(3:0)     |
--        --/--| data3_i(3:0)     |
--          4  |        dig_o(3:0)|--/--
--        --/--| dp_i(3:0)        |  4
--          4  +------------------+
--
-- Inputs:
--   clk
--   reset
--   dataX_i(3:0) -- Data values for individual digits
--   dp_i(3:0)    -- Decimal points for individual digits
--
-- Outputs:
--   dp_o:        -- Decimal point for specific digit
--   seg_o(6:0)   -- Cathode values for individual segments
--   dig_o(3:0)   -- Common anode signals to individual digits
--
------------------------------------------------------------
entity driver_7seg_4digits is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        data_h0_i : in  std_logic_vector(3 downto 0); -- 17.04 - CHANGED ALL TO 4BIT SINCE to_bcd_conv outputs 4bit only
        data_h1_i : in  std_logic_vector(3 downto 0);
        data_m0_i : in  std_logic_vector(3 downto 0);
        data_m1_i : in  std_logic_vector(3 downto 0);
        data_s0_i : in  std_logic_vector(3 downto 0);
        data_s1_i : in  std_logic_vector(3 downto 0);
        seg_o   : out std_logic_vector(6 downto 0);
        dig_o   : out std_logic_vector(5 downto 0)
    );
end entity driver_7seg_4digits;

------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------
architecture Behavioral of driver_7seg_4digits is

    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal 2-bit counter for multiplexing 4 digits
    signal s_cnt : std_logic_vector(2 downto 0);
    -- Internal 4-bit value for 7-segment decoder
    signal s_hex : std_logic_vector(3 downto 0);

begin
    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 4 ms
    clk_en0 : entity work.clock_enable
        generic map(
            -- FOR SIMULATION, CHANGE THIS VALUE TO 4
            -- FOR IMPLEMENTATION, KEEP THIS VALUE TO 400,000
            g_MAX => 100000
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );

    --------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs a 2-bit
    -- down counter
    bin_cnt0 : entity work.cnt_up_down_2
        generic map(
            g_CNT_WIDTH => 3
        )
        port map(
            en_i      => s_en,
            cnt_up_i  => '0',
            reset     => reset,
            clk       => clk,
            cnt_o     => s_cnt
        );

    --------------------------------------------------------
    -- Instance (copy) of hex_7seg entity performs a 7-segment
    -- display decoder
    hex2seg : entity work.hex_7seg
        port map(
            hex_i => s_hex,
            seg_o => seg_o
        );

    --------------------------------------------------------
    -- p_mux:
    -- A sequential process that implements a multiplexer for
    -- selecting data for a single digit, a decimal point 
    -- signal, and switches the common anodes of each display.
    --------------------------------------------------------
    p_mux : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                s_hex <= data_s1_i;
                
                dig_o <= "111110";
            else
                case s_cnt is
                    when "000" =>  -- SEC   
                        s_hex <= data_s0_i;
                        dig_o <= "111110";

                    when "001" =>
                        s_hex <= data_s1_i;
                        dig_o <= "111101";

                    when "010" =>
                        s_hex <= data_m0_i;
                        dig_o <= "111011";
                    
                    when "011" =>
                        s_hex <=  data_m1_i;
                        dig_o <= "110111";
                        
                   when "100" =>
                        s_hex <=  data_h0_i;
                        dig_o <= "101111";

                   when others =>
                        s_hex <=  data_h1_i;
                        dig_o <= "011111";
                end case;
            end if;
        end if;
    end process p_mux;

end architecture Behavioral;
