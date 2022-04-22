----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2022 14:10:00
-- Design Name: 
-- Module Name: clock_setter - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_setter is
    Port ( button_1 : in STD_LOGIC;
           button_2 : in STD_LOGIC;
           button_3 : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (1 downto 0);
           seconds_o : out STD_LOGIC_VECTOR(5 downto 0);
           minutes_o : out STD_LOGIC_VECTOR(5 downto 0);
           hours_o : out STD_LOGIC_VECTOR(4 downto 0));
           
        
end clock_setter;

architecture Behavioral of clock_setter is
    signal ss, mm : integer range 0 to 59;
    signal hr : integer range 0 to 23;
begin

clock_setter : process
begin
    if(sw(0) = '1') then
        if(button_1 = '1') then
            hr <= hr + 1;
        elsif(button_2 = '1') then
            mm <= mm + 1;
        elsif (button_3 = '1') then
            ss <= ss + 1;
        end if;
    end if;
    wait;
end process clock_setter;

seconds_o <= conv_std_logic_vector(ss,6);
minutes_o <= conv_std_logic_vector(mm,6);
hours_o <= conv_std_logic_vector(hr,5);
end Behavioral;
