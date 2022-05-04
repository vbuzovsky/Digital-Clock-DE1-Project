library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
 
entity to_bcd_conv is 
    generic(
        g_CONV_WIDTH : natural := 5  -- 5 DEFAILT FOR SECONDS,MINUTES | 4 FOR HOURS
    );
  port ( 
    in_binary :  in std_logic_vector(g_CONV_WIDTH downto 0);  -- 6 BIT FOR SECONDS,MINUTES | 5 FOR HOURS
    digit_0   : out std_logic_vector( 3 downto 0); 
    digit_1   : out std_logic_vector( 3 downto 0)  
  ); 
end entity to_bcd_conv; 
----------------------------------- 
architecture behavioral of to_bcd_conv is 

begin  
-- NO IDEA IF THIS WORKS YIKES
-- https://www.quora.com/How-do-I-convert-an-8-bit-binary-number-to-BCD-in-VHDL <---- CODE FROM HERE
  process(in_binary) 
    variable s_digit_0 : unsigned( 3 downto 0); 
    variable s_digit_1 : unsigned( 3 downto 0); 

  begin 
    s_digit_1 := "0000"; 
    s_digit_0 := "0000"; 
 
    for i in g_CONV_WIDTH downto 0 loop 
      if (s_digit_1 >= 5) then s_digit_1 := s_digit_1 + 3; end if; 
      if (s_digit_0 >= 5) then s_digit_0 := s_digit_0 + 3; end if; 
      s_digit_1 := s_digit_1 sll 1; s_digit_1(0) := s_digit_0(3); 
      s_digit_0 := s_digit_0 sll 1; s_digit_0(0) := in_binary(i); 
    end loop; 
 
    digit_0 <=  std_logic_vector(s_digit_0); 
    digit_1 <=  std_logic_vector(s_digit_1); 
  end process; 
 
end architecture behavioral;