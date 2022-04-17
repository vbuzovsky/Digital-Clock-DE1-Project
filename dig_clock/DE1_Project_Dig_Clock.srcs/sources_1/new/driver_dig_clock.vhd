----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2022 17:08:23
-- Design Name: 
-- Module Name: driver_dig_clock - Behavioral
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

entity driver_dig_clock is
     port(
        clk     : in  std_logic;
        rst     : in std_logic;
        h0_o : out std_logic_vector(3 downto 0);
        h1_o : out std_logic_vector(3 downto 0);
        m0_o : out std_logic_vector(3 downto 0);
        m1_o : out std_logic_vector(3 downto 0);
        s0_o : out std_logic_vector(3 downto 0);
        s1_o : out std_logic_vector(3 downto 0)
    );
end driver_dig_clock;

architecture Behavioral of driver_dig_clock is
    signal s_secs  : std_logic_vector(5 downto 0);
    signal s_mins : std_logic_vector(5 downto 0);
    signal s_hrs : std_logic_vector(4 downto 0);
begin
    digital_clock : entity work.digital_clock
        port map(
            clk_100   => clk,
            reset => rst,

        );

    to_bcd_conv : entity work.to_bcd_conv
end Behavioral;
