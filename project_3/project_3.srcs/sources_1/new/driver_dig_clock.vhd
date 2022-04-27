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
        clk  : in  std_logic;
        rst  : in std_logic;
        sw_i : in std_logic;
        btn_1_i : in std_logic;
        btn_2_i : in std_logic;
        btn_3_i : in std_logic;
        btn_4_i : in std_logic; -- BUTTON PRO PREPIS HODNOT V CLOCKU
        activate_sw : in STD_LOGIC;
        h0_o : out std_logic_vector(3 downto 0);
        h1_o : out std_logic_vector(3 downto 0);
        m0_o : out std_logic_vector(3 downto 0);
        m1_o : out std_logic_vector(3 downto 0);
        s0_o : out std_logic_vector(3 downto 0);
        s1_o : out std_logic_vector(3 downto 0);
        ring_o : out std_logic

    );
end driver_dig_clock;

architecture Behavioral of driver_dig_clock is
    signal s_en : std_logic;
    signal s_en1 : std_logic;
--Internal signals from p_mux to bcd_conv
    signal s_secs  : std_logic_vector(5 downto 0);
    signal s_mins : std_logic_vector(5 downto 0);
    signal s_hrs : std_logic_vector(4 downto 0);
-- Internal signals from digital_clock to p_mux
    signal s_d_secs  : std_logic_vector(5 downto 0);
    signal s_d_mins : std_logic_vector(5 downto 0);
    signal s_d_hrs : std_logic_vector(4 downto 0);
-- Internal signals from clock_setter to p_mux and dig_clock
    signal s_c_secs : std_logic_vector(5 downto 0):=(others => '0');
    signal s_c_mins : std_logic_vector(5 downto 0):=(others => '0');
    signal s_c_hrs : std_logic_vector(4 downto 0):=(others => '0');
begin
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 100000000
        )
        port map(
            clk   => clk,
            reset => rst,
            ce_o  => s_en
        );
     clk_en1 : entity work.clock_enable
        generic map(
            g_MAX => 10000000
        )
        port map(
            clk   => clk,
            reset => rst,
            ce_o  => s_en1
        );
    
    digital_clock : entity work.digital_clock
        port map(
            clk   => clk,
            rst => rst,
            en_i => s_en,
            -- HODNOTY Z VYSTUPU clock_setter + BUTTON
            btn_set => btn_4_i,
            set_second => s_c_secs,
            set_minute => s_c_mins,
            set_hour => s_c_hrs,
            
            sec_o => s_d_secs,
            min_o => s_d_mins,
            hr_o => s_d_hrs
        );
    
    clock_setter : entity work.clock_setter
        port map(
           button_1 => btn_1_i,
           button_2 => btn_2_i,
           en_i => s_en1,
           clk => clk,
           sw => sw_i,
           sec_o => s_c_secs,
           min_o => s_c_mins,
           hr_o => s_c_hrs
        );
        
    alarm : entity work.time_comp_alarm
        port map(
            button_set => btn_3_i,
            ring => ring_o,
            activate_sw_i => activate_sw,
            set_minute => s_c_mins,
            set_hour => s_c_hrs,
            
            current_minute => s_d_mins,
            current_hour => s_d_hrs
        );
    
    to_bcd_conv_s : entity work.to_bcd_conv
        generic map(
            g_CONV_WIDTH => 5
        )
        port map(
            in_binary => s_secs,
            digit_0 => s0_o,
            digit_1 => s1_o
        );
    to_bcd_conv_m : entity work.to_bcd_conv
        generic map(
            g_CONV_WIDTH => 5
        )
        port map(
            in_binary => s_mins,
            digit_0 => m0_o,
            digit_1 => m1_o
        );
    to_bcd_conv_h : entity work.to_bcd_conv
        generic map(
            g_CONV_WIDTH => 4
        )
        port map(
            in_binary => s_hrs,
            digit_0 => h0_o,
            digit_1 => h1_o
        );
        
        
    --MUX FOR CLOCK_SETTER & DIG_CLOCK    
    p_mux : process(clk)
    begin
        if rising_edge (clk) then
            case sw_i is
                when '1' =>
                    s_secs <= s_c_secs;
                    s_mins <= s_c_mins;
                    s_hrs <= s_c_hrs;
                when others =>
                    s_secs <= s_d_secs;
                    s_mins <= s_d_mins;
                    s_hrs <= s_d_hrs;
            end case;
         end if;
    end process p_mux;
end Behavioral;
