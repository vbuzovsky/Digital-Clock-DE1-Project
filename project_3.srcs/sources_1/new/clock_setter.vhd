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
begin




end Behavioral;
