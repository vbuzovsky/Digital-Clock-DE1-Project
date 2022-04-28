----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2022 18:33:55
-- Design Name: 
-- Module Name: button_debouncer - Behavioral
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


-- DEBOUNCER FOR ALL 4 BUTTONS ON BOARD
-- SOURCE:
-- https://www.youtube.com/watch?v=8ISfNm9zv18&ab_channel=LBEbooks 

entity button_debouncer is
    Port ( input : in STD_LOGIC;
           cclk : in STD_LOGIC;
           rst : in STD_LOGIC;
           output : out STD_LOGIC);
end button_debouncer;

architecture Behavioral of button_debouncer is

signal delay1, delay2, delay3 : std_logic;
signal s_en : std_logic;

begin

    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 1 --1000000 for implementation 1 for simulation
        )
        port map(
            clk   => cclk,
            reset => rst,
            ce_o  => s_en
        );

    process(cclk)
    begin
        if(rising_edge(cclk)) then
            if(rst = '1') then
                delay1 <= '0';
                delay2 <= '0';
                delay3 <= '0';
            elsif(s_en = '1') then
                delay1 <= input;
                delay2 <= delay1;
                delay3 <= delay2;
            end if;
      end if;
    end process;
        
    output <= delay1 and delay2 and delay3;    
       
end Behavioral;
