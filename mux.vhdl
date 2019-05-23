-- mux.vhdl
-- CPEG324 - Lab 2

library ieee;
use ieee.std_logic_1164.all;

entity mux is
    generic (n : integer);
    port (
        A   :    in std_logic_vector (n-1 downto 0);
        B   :    in std_logic_vector (n-1 downto 0);
        C   :    in std_logic_vector (n-1 downto 0);
        D   :    in std_logic_vector (n-1 downto 0);
        sel :    in std_logic_vector (1 downto 0);
        O   :    out std_logic_vector (n-1 downto 0)
    );
end mux;

architecture behave of mux is
begin
    process(sel)
    begin
        case sel is
            when "00" => O <= A;
            when "01" => O <= B;
            when "10" => O <= C;
            when others => O <= D;
        end case;
    end process;
end behave;