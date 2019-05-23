-- 4bit_adder_tb.vhdl
-- CPEG324 - Lab 2
-- 4bit adder testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_adder_tb is
end entity four_bit_adder_tb;

architecture behave of four_bit_adder_tb is

    component four_bit_adder is
        port
        (
            A:	in std_logic_vector (3 downto 0);
            B:	in std_logic_vector (3 downto 0);
            OP: in std_logic;   -- 0 = add, 1 = subtract
            S:	out std_logic_vector(3 downto 0);
            over:   out std_logic
        );
    end component;
    
    -- Signals
    signal a, b, s : std_logic_vector (3 downto 0);
    signal op, ov, un : std_logic;
    
    begin
        --  Component
        comp: four_bit_adder
            port map (
                A => a,
                B => b,
                OP => op,
                S => s,
                over => ov
            );
           
    -- Testbench
    process
    
        type entry is record
            a   : std_logic_vector (3 downto 0);
            b   : std_logic_vector (3 downto 0);
            op  : std_logic;
            s   : std_logic_vector (3 downto 0);
            ov  : std_logic;
        end record;
        
        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list :=(
            ("0000", "0000" , '0', "0000", '0'),
            ("0111", "0001" , '0', "1000", '0'),
            ("1000", "0001" , '1', "0111", '1'),
            ("0011", "0010" , '0', "0101", '0')
        );
        
        begin
	
        -- Test
        for i in entries'range loop
            a <= entries(i).a;
            b <= entries(i).b;
            op <= entries(i).op;
            
            wait for 1 ns;
            
            assert s = entries(i).s report "Incorrect sum!" severity error;
            assert ov = entries(i).ov report "Incorrect carry!" severity error;
        end loop;
        
        report "End test";
        wait;
    end process;
end behave;