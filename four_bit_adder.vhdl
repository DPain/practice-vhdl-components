-- four_bit_adder.vhdl
-- CPEG324 - Lab 2
-- 4Bit adder

library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder is
	port
    (
        A:	in std_logic_vector (3 downto 0);
        B:	in std_logic_vector (3 downto 0);
        OP: in std_logic;   -- 0 = add, 1 = subtract
        S:	out std_logic_vector(3 downto 0);
        over:   out std_logic
	);
end entity four_bit_adder;

architecture structural of four_bit_adder is

    component full_adder is
        port
        (
            A, B, Cin : in std_logic;
            S, Cout : out std_logic
        );
    end component;
    
    -- Signals
    signal cint : std_logic_vector (2 downto 0);
    signal bint : std_logic_vector (3 downto 0);
    signal carry : std_logic;
    
    begin
        bint(0) <= B(0) xor OP;
		bint(1) <= B(1) xor OP;
		bint(2) <= B(2) xor OP;
		bint(3) <= B(3) xor OP;
            
        fa_0: full_adder port map(
                A => A(0),
                B => bint(0),
                Cin => OP,
                S => S(0),
                Cout => cint(0)
            );

        fa_1: full_adder port map(
                    A => A(1),
                    B => bint(1),
                    Cin => cint(0),
                    S => S(1),
                    Cout => cint(1)
                );
				
		fa_2: full_adder port map(
                    A => A(2),
                    B => bint(2),
                    Cin => cint(1),
                    S => S(2),
                    Cout => cint(2)
                );
				
		fa_3: full_adder port map(
                    A => A(3),
                    B => bint(3),
                    Cin => cint(2),
                    S => S(3),
                    Cout => over
                );
        
end architecture;