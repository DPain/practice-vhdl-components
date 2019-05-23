-- shift_reg_eight.vhdl
-- CPEG324 - Lab 2

library ieee;
use ieee.std_logic_1164.all;

entity shift_reg_eight is
    port(
        I           :   in std_logic_vector (7 downto 0);
        I_SHIFT_IN  :   in std_logic;
        sel         :   in std_logic_vector(1 downto 0); -- 00: load, 01: hold, 10: right shift, 11: left shift
        clock       :   in std_logic;
        enable      :   in std_logic;
        O           :   out std_logic_vector(7 downto 0)
    );
end shift_reg_eight;

architecture struct of shift_reg_eight is

component shift_reg is
    port
	(   
        I           :   in std_logic_vector (3 downto 0);
        I_SHIFT_IN  :   in std_logic;
        sel         :   in std_logic_vector(1 downto 0); -- 00: load, 01: hold, 10: right shift, 11: left shift
        clock       :   in std_logic;
        enable      :   in std_logic;
        O           :   out std_logic_vector(3 downto 0)
    );
end component shift_reg;

signal shift_dir0, shift_dir1 : std_logic;
signal output : std_logic_vector(7 downto 0) := "00000000";

begin
    shift_reg0: shift_reg 
	port map (
        I => I(7 downto 4),
        I_SHIFT_IN => shift_dir0,
        sel => sel,
        clock => clock,
		enable => enable, 
		O => output(7 downto 4)
	);
	shift_reg1: shift_reg 
	port map (
        I => I(3 downto 0),
        I_SHIFT_IN => shift_dir0,
        sel => sel,
        clock => clock,
		enable => enable, 
		O => output(3 downto 0)
	);
    
    shift_dir0 <= output(3) when sel = "10" else I_SHIFT_IN;
    shift_dir1 <= output(4) when sel = "01" else I_SHIFT_IN;

    O <= output;
    
end struct;