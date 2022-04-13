------------------------------------------------------------
--
-- Example of 4-bit binary comparator using the when/else
-- assignments.
-- EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for ...
------------------------------------------------------------
entity mux_3bit_4to1 is
    port(
        sel_i         : in  std_logic_vector(2 - 1 downto 0);
        d_i           : in  std_logic_vector(3 - 1 downto 0);
        c_i           : in  std_logic_vector(3 - 1 downto 0);
        b_i           : in  std_logic_vector(3 - 1 downto 0);
        a_i           : in  std_logic_vector(3 - 1 downto 0);
        
        mux_o  : out std_logic_vector(3 - 1 downto 0)
        
    );
end entity mux_3bit_4to1;

------------------------------------------------------------
-- Architecture body for ...
------------------------------------------------------------
architecture Behavioral of mux_3bit_4to1 is
begin
    with sel_i select
    mux_o <= a_i when "00",
             b_i when "01",
             c_i when "10",
             d_i when "11",
             "000" when others;
             
end architecture Behavioral;