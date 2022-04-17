library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity digital_clock is
port(clk_100 : in std_logic;
    reset : in std_logic;
  second : out std_logic_vector(5 downto 0);
  minute : out std_logic_vector(5 downto 0);
  hour : out std_logic_vector(4 downto 0));
end entity;

architecture behavorial of digital_clock is
signal ss, mm : integer range 0 to 59;
signal hr : integer range 0 to 23;
signal count : integer := 1;
signal clk1 : std_logic := '1';

begin
  clk_en0 : entity work.clock_enable
        generic map(
            -- FOR SIMULATION, CHANGE THIS VALUE TO 4
            -- FOR IMPLEMENTATION, KEEP THIS VALUE TO 400,000
            g_MAX => 4
        )
        port map(
            clk   => clk_100,
            reset => reset,
            ce_o  => s_en -- WHERE TO CONNECT THIS ???
        );
-- Functionality of Digital Clock.
digital : process (clk1)

-- https://vlsicoding.blogspot.com/2016/01/vhdl-code-for-digital-clock.html <---- CODE FROM HERE

 begin
  if (rising_edge(clk1)) then
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
 end process;

--Converts Integer Values into Standard Logic Vector. 
second <= conv_std_logic_vector(ss,6);
minute <= conv_std_logic_vector(mm,6);
hour <= conv_std_logic_vector(hr,5);

end behavorial;