-- mux_tb.vhdl
-- CPEG324 - Lab 2
-- Mux testbench

library ieee;
use ieee.std_logic_1164.all;

entity mux_tb is
end mux_tb;

architecture behave of mux_tb is

    component mux
        generic (n : integer);
        port (
            A   :    in std_logic_vector (n-1 downto 0);
            B   :    in std_logic_vector (n-1 downto 0);
            C   :    in std_logic_vector (n-1 downto 0);
            D   :    in std_logic_vector (n-1 downto 0);
            sel :    in std_logic_vector (1 downto 0);
            O   :    out std_logic_vector (n-1 downto 0)
        );
    end component;

    -- Signals
    signal a, b, c, d, o : std_logic_vector(7 downto 0);
    signal sel : std_logic_vector(1 downto 0);


    begin
        -- Component
        comp: mux 
        generic map (
            n => 8
        )
        port map (
            A => a,
            B => b,
            C => c,
            D => d,
            sel => sel,
            O => o
        );

    -- Testbench
    process
        type entry is record
            a   : std_logic_vector (7 downto 0);
            b   : std_logic_vector (7 downto 0);
            c   : std_logic_vector (7 downto 0);
            d   : std_logic_vector (7 downto 0); 
            sel : std_logic_vector (1 downto 0);
            o   : std_logic_vector (7 downto 0);
        end record;

        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list := (
            ("00000001", "00000011", "00000111", "00001111", "00", "00000001"),
            ("00000001", "00000011", "00000111", "00001111", "01", "00000011"),
            ("00000001", "00000011", "00000111", "00001111", "10", "00000111"),
            ("00000001", "00000011", "00000111", "00001111", "11", "00001111")
        );

        begin
        
        -- Test
        for i in entries'range loop
            a <= entries(i).a;
            b <= entries(i).b;
            c <= entries(i).c;
            d <= entries(i).d;
            sel <= entries(i).sel;
            
            wait for 1 ns;
            
            assert o = entries(i).o report "Incorrect!" severity error;
        end loop;
        
        report "End test";
        wait;
    end process;
end behave;