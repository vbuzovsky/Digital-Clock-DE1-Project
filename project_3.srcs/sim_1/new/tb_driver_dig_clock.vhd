----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2022 22:54:27
-- Design Name: 
-- Module Name: tb_driver_dig_clock - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_driver_dig_clock is

end tb_driver_dig_clock;

architecture Behavioral of tb_driver_dig_clock is
    
    constant clk_freq : integer := 100e6;
    constant clk_per : time := 1000 ms / clk_freq;
    --Local signals - inputs
    signal s_clk_100MHZ : std_logic := '0';
    signal s_rst : std_logic;
    --Local signals - outputs
    signal s_h0 : std_logic_vector(3 downto 0);
    signal s_h1 : std_logic_vector(3 downto 0);
    signal s_m0 : std_logic_vector(3 downto 0);
    signal s_m1 : std_logic_vector(3 downto 0);
    signal s_s0 : std_logic_vector(3 downto 0);
    signal s_s1 : std_logic_vector(3 downto 0);
begin
    -- Testing driver_dig_clock
   uut_driver_dig_clock : entity work.driver_dig_clock
        port map(
            clk => s_clk_100MHZ,
            rst => s_rst,
            h0_o => s_h0,
            h1_o => s_h1,
            m0_o => s_m0,
            m1_o => s_m1,
            s0_o => s_s0,
            s1_o => s_s1
        );
    --CLOCK GENERATION
    s_clk_100MHZ <= not s_clk_100MHZ after clk_per / 2;
    --RESET GENERATION
    p_reset_gen : process
    begin
        s_rst <= '0';
        wait for 200 ns;
        s_rst <= '1';
        wait for 500 ns;
        s_rst <= '0';
        wait;
    end process p_reset_gen;
    p_stimulus : process
    begin
        report "Stimulus started" severity note;
        wait;
    end process p_stimulus;
end Behavioral;
