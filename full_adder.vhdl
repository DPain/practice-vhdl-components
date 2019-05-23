-- full_adder.vhdl
-- CPEG324 - Lab 2
-- Very rudimentary full adder design.

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port
	(
		A, B, Cin : in std_logic;
        S, Cout : out std_logic
	);
end entity full_adder;

architecture behave of full_adder is
	begin
		process(A, B, Cin)
	begin
		S <= A xor (B xor Cin);
		Cout <= (B and Cin) or (A and Cin) or (A and B);
	end process;
end architecture behave;