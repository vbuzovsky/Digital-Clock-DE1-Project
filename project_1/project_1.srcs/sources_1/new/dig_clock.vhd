library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

entity digital_clock is
    port(
        clk : in std_logic;
        reset : in std_logic;
        
        set_button : in std_logic;
        set_second : in std_logic_vector(5 downto 0);
        set_minute : in std_logic_vector(5 downto 0);
        set_hour : in std_logic_vector(4 downto 0);
        
        second : out std_logic_vector(5 downto 0);
        minute : out std_logic_vector(5 downto 0);
        hour : out std_logic_vector(4 downto 0)
    );
end entity;

architecture Behavorial of digital_clock is
    signal ss, mm : integer range 0 to 59;
    signal hr : integer range 0 to 23;
    signal s_en : std_logic;

begin
  clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 4
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );
        
-- Functionality of Digital Clock.
digital : process (clk)
-- https://vlsicoding.blogspot.com/2016/01/vhdl-code-for-digital-clock.html <---- CODE FROM HERE
 begin
  if (rising_edge(clk)) then
    if(reset = '1') then
        ss <= 0;
        mm <= 0;
        hr <= 0;
    elsif(set_button = '1') then
        -- https://support.xilinx.com/s/article/45213?language=en_US
        -- CONV VECTOR TO INTEGER CODE
        ss <= conv_integer(set_second);
        mm <= conv_integer(set_minute);
        hr <= conv_integer(set_hour);
    elsif (s_en = '1') then
        if (ss = 59) then
            ss <= 0;
            if (mm = 59) then
                mm <= 0;
                if (hr = 23) then
                    hr <= 0;
                else
                    hr <= hr + 1;
                end if;
            else
                mm <= mm + 1;
            end if;
        else
            ss <= ss + 1;
        end if;
   end if;
  end if;
 end process;

--Converts Integer Values into Standard Logic Vector. 
second <= conv_std_logic_vector(ss,6);
minute <= conv_std_logic_vector(mm,6);
hour <= conv_std_logic_vector(hr,5);

end Behavorial;