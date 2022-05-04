library ieee;
use ieee.std_logic_1164.all;


entity tb_to_bcd_conv is

end entity tb_to_bcd_conv;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_to_bcd_conv is
    constant   g_CONV_WIDTH : natural := 5;  -- 5 DEFAILT FOR SECONDS,MINUTES | 4 FOR HOURS

    -- Local signals
    signal s_binary  : std_logic_vector(g_CONV_WIDTH downto 0);
    signal s_dig0  : std_logic_vector(3 downto 0);
    signal s_dig1 : std_logic_vector(3 downto 0);

begin
    -- Connecting testbench signals with decoder entity
    -- (Unit Under Test)
    uut_to_bcd_conv : entity work.to_bcd_conv
        port map(
            in_binary => s_binary,
            digit_0 => s_dig0,
            digit_1 => s_dig1
        );

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        -- First test case
        s_binary  <= "000001";wait for 50 ns; --1
        assert (s_dig0 = "0001")
        report "Input combination 000001 FAILED" severity error;
        
        s_binary  <= "000010";wait for 50 ns; --2
        assert (s_dig0 = "0010")
        report "Input combination 000010 FAILED" severity error;
        
        s_binary  <= "000011";wait for 50 ns; --3
        assert (s_dig0 = "0011")
        report "Input combination 000011 FAILED" severity error;
        
        s_binary  <= "010111";wait for 50 ns; --23
        assert (s_dig0 = "0011" and s_dig1 = "0010")
        report "Input combination 010111 FAILED" severity error;
        
        s_binary  <= "001111";wait for 50 ns; --15
        assert (s_dig0 = "0101" and s_dig1 = "0001")
        report "Input combination 001111 FAILED" severity error;
        
        s_binary  <= "100110";wait for 50 ns; --38
        assert (s_dig0 = "1000" and s_dig1 = "0011")
        report "Input combination 100110 FAILED" severity error;
        
        s_binary  <= "001100";wait for 50 ns; --12
        assert (s_dig0 = "0010" and s_dig1 = "0001")
        report "Input combination 001100 FAILED" severity error;
        
        s_binary  <= "110011";wait for 50 ns; --51
        assert (s_dig0 = "0001" and s_dig1 = "0101")
        report "Input combination 110011 FAILED" severity error;
        
        s_binary  <= "101100";wait for 50 ns; --44
        assert (s_dig0 = "0100" and s_dig1 = "0100")
        report "Input combination 101100 FAILED" severity error;
        
        s_binary  <= "111011";wait for 50 ns; --59
        assert (s_dig0 = "1001" and s_dig1 = "0101")
        report "Input combination 111011 FAILED" severity error;
        
        
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;