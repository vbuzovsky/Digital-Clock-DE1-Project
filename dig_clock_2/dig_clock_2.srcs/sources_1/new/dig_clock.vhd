library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity digital_clock is
    port(
        clk   : in std_logic;
        rst   : in std_logic;
        en_i  : in std_logic;
      --Clock_setter inputs
        btn_set : in std_logic;
        set_second : in std_logic_vector(5 downto 0);
        set_minute : in std_logic_vector(5 downto 0);
        set_hour : in std_logic_vector(4 downto 0);
      --Seperate outputs for hours, minutes and seconds  
        sec_o  : out std_logic_vector(5 downto 0);
        min_o  : out std_logic_vector(5 downto 0);
        hr_o   : out std_logic_vector(4 downto 0)
    );
end entity;

architecture Behavorial of digital_clock is
-- Internal unsigned signals for hours, minutes and seconds counters
    signal s_sec : unsigned (5 downto 0) := (others => '0');
    signal s_min : unsigned (5 downto 0) := (others => '0');
    signal s_hr  : unsigned (4 downto 0) := (others => '0');

begin   
-- Functionality of Digital Clock.
-- https://vlsicoding.blogspot.com/2016/01/vhdl-code-for-digital-clock.html <---- CODE FROM HERE
    p_dig_clock : process(clk)
    begin
        if rising_edge(clk) then
        
            if (rst = '1') then   -- Synchronous reset
                s_hr <= (others => '0');
                s_min <= (others => '0');
                s_sec <= (others => '0');
            elsif (btn_set = '1') then --Loading settings from clock_setter
             --Conversion logic_vector to unsigned
                s_hr <= unsigned (set_hour);
                s_min <= unsigned (set_minute);
                s_sec <= unsigned (set_second);
            elsif (en_i = '1') then -- Test if counter is enabled
            
                if(s_sec = "111011") then -- Test if sec counter is 59, and resetting it if true
                    s_sec <= (others => '0');
                    
                    if (s_min = "111011") then -- Test if min counter is 59, and resetting it if true 
                        s_min <= (others => '0');
                        
                        if (s_hr = "10111") then -- Test if hr counter is 23, and resetting it if true
                            s_hr <= (others => '0');
                         else
                            s_hr <= s_hr + 1;
                         end if; 
                    else
                        s_min <= s_min + 1;
                    end if;
                else
                    s_sec <= s_sec + 1;
                end if;
            end if;
        end if;
    end process p_dig_clock;

    -- Retyping counters from unsigned to logic vector
    sec_o <= std_logic_vector(s_sec);
    min_o <= std_logic_vector(s_min);
    hr_o <= std_logic_vector(s_hr);
end Behavorial;