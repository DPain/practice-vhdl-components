-- shift_reg_tb.vhdl
-- CPEG324 - Lab 2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_reg_tb is
end shift_reg_tb;

architecture struct of shift_reg_tb is

    component shift_reg is
        port(
            I           :   in std_logic_vector (3 downto 0);
            I_SHIFT_IN  :   in std_logic;
            sel         :   in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
            clock       :   in std_logic;
            enable      :   in std_logic;
            O           :   out std_logic_vector(3 downto 0)
        );
    end component shift_reg;

    signal clk : std_logic := '0';
    signal i, o : std_logic_vector(3 downto 0);
    signal seli : std_logic_vector(1 downto 0);
    signal i_shift_in, en : std_logic;


    begin
        comp: shift_reg 
        port map (
            I => i, 
            I_SHIFT_IN => i_shift_in, 
            sel => seli, 
            clock => clk, 
            enable => en, 
            O => o
        );
        
    process
        type entry is record
            i           :   std_logic_vector (3 downto 0);
            i_shift_in  :   std_logic;
            seli        :   std_logic_vector(1 downto 0);
            en          :   std_logic;
            clk         :   std_logic;
            o           :   std_logic_vector(3 downto 0);
        end record;

        type entry_list is array (natural range <>) of entry;
        constant entries : entry_list := (
            ("0001", '0', "11", '1', '1', "0000"),
            ("0001", '0', "00", '0', '1', "0000"),
            ("0001", '0', "00", '1', '0', "0000"),
            ("0001", '0', "00", '1', '1', "0000"),
            ("0001", '0', "01", '0', '0', "0000"),
            ("0001", '0', "01", '0', '1', "0000"),
            ("0001", '0', "01", '1', '0', "0000"),
            ("0001", '0', "01", '1', '1', "0000"),
            ("0001", '0', "10", '0', '0', "0000"),
            ("0001", '0', "10", '0', '1', "0000"),
            ("0001", '0', "10", '1', '0', "0000"),
            ("0001", '0', "10", '1', '1', "0000"),
            ("0001", '0', "11", '0', '0', "0000"),
            ("0001", '0', "11", '0', '1', "0000"),
            ("0001", '0', "11", '1', '0', "0000"),
            ("0001", '0', "11", '1', '1', "0001"), -- 16 ns
            ("0001", '1', "00", '0', '0', "0001"),
            ("0001", '1', "00", '0', '1', "0001"),
            ("0001", '1', "00", '1', '0', "0001"),
            ("0001", '1', "00", '1', '1', "0001"),
            ("0001", '1', "01", '0', '0', "0001"),
            ("0001", '1', "01", '0', '1', "0001"),
            ("0001", '1', "01", '1', '0', "0001"),
            ("0001", '1', "01", '1', '1', "1000"), -- 24 ns
            ("0001", '1', "10", '0', '0', "1000"),
            ("0001", '1', "10", '0', '1', "1000"),
            ("0001", '1', "10", '1', '0', "1000"),
            ("0001", '1', "10", '1', '1', "0001"),
            ("0001", '1', "11", '0', '0', "0001"),
            ("0001", '1', "11", '0', '1', "0001"),
            ("0001", '1', "11", '1', '0', "0001"),
            ("0001", '1', "11", '1', '1', "0001"),
            ("0101", '0', "00", '0', '0', "0001"),
            ("0101", '0', "00", '0', '1', "0001"),
            ("0101", '0', "00", '1', '0', "0001"),
            ("0101", '0', "00", '1', '1', "0001"),
            ("0101", '0', "01", '0', '0', "0001"),
            ("0101", '0', "01", '0', '1', "0001"),
            ("0101", '0', "01", '1', '0', "0001"),
            ("0101", '0', "01", '1', '1', "0000"),
            ("0101", '0', "10", '0', '0', "0000"),
            ("0101", '0', "10", '0', '1', "0000"),
            ("0101", '0', "10", '1', '0', "0000"),
            ("0101", '0', "10", '1', '1', "0000"),
            ("0101", '0', "11", '0', '0', "0000"),
            ("0101", '0', "11", '0', '1', "0000"),
            ("0101", '0', "11", '1', '0', "0000"),
            ("0101", '0', "11", '1', '1', "0101"),
            ("0101", '1', "00", '0', '0', "0101"),
            ("0101", '1', "00", '0', '1', "0101"),
            ("0101", '1', "00", '1', '0', "0101"),
            ("0101", '1', "00", '1', '1', "0101"),
            ("0101", '1', "01", '0', '0', "0101"),
            ("0101", '1', "01", '0', '1', "0101"),
            ("0101", '1', "01", '1', '0', "0101"),
            ("0101", '1', "01", '1', '1', "1010"),
            ("0101", '1', "10", '0', '0', "1010"),
            ("0101", '1', "10", '0', '1', "1010"),
            ("0101", '1', "10", '1', '0', "1010"),
            ("0101", '1', "10", '1', '1', "0101"),
            ("0101", '1', "11", '0', '0', "0101"),
            ("0101", '1', "11", '0', '1', "0101"),
            ("0101", '1', "11", '1', '0', "0101"),
            ("0101", '1', "11", '1', '1', "0101")
        );

        begin
        
        -- Test
        for n in entries'range loop
            i <= entries(n).i;
            i_shift_in <= entries(n).i_shift_in;
            seli <= entries(n).seli;
            clk <= entries(n).clk;
            en <= entries(n).en;
            
            wait for 1 ns;
            
            report " " & integer'image(to_integer(signed(o)));
            report " " & integer'image(to_integer(signed(entries(n).o)));
            report " ";
            assert o = entries(n).o report "Incorrect!" severity error;
        end loop;
        
        report "End test";
        wait;
    end process;
    
end struct;