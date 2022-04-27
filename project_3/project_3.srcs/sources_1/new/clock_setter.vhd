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
use IEEE.NUMERIC_STD.ALL;

entity clock_setter is
    Port ( 
           --Buttons for adjusting the clock
           button_1 : in STD_LOGIC;
           button_2 : in STD_LOGIC;
           clk : in std_logic;
           en_i : in std_logic;
           --Switch to enable clock_setter
           sw : in STD_LOGIC;
           --Clock_setter outputs
           sec_o : out STD_LOGIC_VECTOR(5 downto 0);
           min_o : out STD_LOGIC_VECTOR(5 downto 0);
           hr_o : out STD_LOGIC_VECTOR(4 downto 0)
    );
end clock_setter;

architecture Behavioral of clock_setter is
-- Internal unsigned signals for hours, minutes and seconds - default value 0
    signal s_sec : unsigned (5 downto 0) := (others => '0');
    signal s_min : unsigned (5 downto 0) := (others => '0');
    signal s_hr  : unsigned (4 downto 0) := (others => '0');

begin
    clock_setter : process (clk)
    begin
        if(rising_edge(clk)) then
            if(en_i = '1') then
                if(sw = '1') then --Check if clock_setter is enabled
                    if(button_1 = '1') then -- Check if button for adjusting hours is pressed
                        if (s_hr >= "10111") then
                            s_hr <= (others => '0');
                        else
                            s_hr <= s_hr + 1;
                        end if;
                    elsif(button_2 = '1') then -- Check if button for adjusting minutes is pressed
                        if (s_min >= "111011") then
                            s_min <= (others => '0');
                        else
                            s_min <= s_min + 1;
                        end if;
                   end if;     
                 end if;
              end if;
           end if;
        
    end process clock_setter;
-- Retyping unsigned to logic_vector
    sec_o <= std_logic_vector(s_sec);
    min_o <= std_logic_vector(s_min);
    hr_o <= std_logic_vector(s_hr);
end Behavioral;
