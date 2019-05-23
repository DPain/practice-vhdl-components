-- full_adder_tb.vhdl
-- CPEG324 - Lab 3
-- Full Adder testbench

library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
end entity full_adder_tb;

architecture behave of full_adder_tb is

    component full_adder is
        port
        (
            A, B, Cin : in std_logic;
            S, Cout : out std_logic
        );
    end component;
    
    -- Signals
    signal a, b, in_int : std_logic;
    signal s, out_int : std_logic;
    
    begin
        --  Component
        comp: full_adder 
            port map (
                A => a,
                B => b,
                Cin => in_int,
                S => s,
                Cout => out_int
            );
           
    -- Testbench
    process
    
        type entry is record
            a        : std_logic;
            b        : std_logic;
            in_int   : std_logic;
            s        : std_logic;
            out_int  : std_logic;
        end record;
        
        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list :=(
            ('0', '0', '0', '0', '0'),
            ('1', '0', '0', '1', '0'),
            ('0', '1', '0', '1', '0'),
            ('1', '1', '0', '0', '1'),
            ('0', '0', '1', '1', '0'),
            ('1', '0', '1', '0', '1'),
            ('0', '1', '1', '0', '1'),
            ('1', '1', '1', '1', '1')
        );
        
        begin
	
        -- Test
        for i in entries'range loop
            a <= entries(i).a;
            b <= entries(i).b;
            in_int <= entries(i).in_int;
            
            wait for 1 ns;
            
            assert s = entries(i).s report "Incorrect Sum!" severity error;
            assert out_int = entries(i).out_int report "Incorrect Carry out!" severity error;
        end loop;
        
        report "End test";
        wait;
    end process;
end behave;