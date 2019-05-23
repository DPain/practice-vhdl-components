-- dff.vhdl
-- CPEG324 - Lab 2

library ieee;
use ieee. std_logic_1164.all;
 
entity dff is
    port
	(   
        clk: in std_logic;
		D: in std_logic;
		en: in std_logic;
        Q: out std_logic
    );
end dff;
 
architecture behave of dff is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (en = '1') then
                Q <= D;
            end if;
        end if;
    end process;
end behave;