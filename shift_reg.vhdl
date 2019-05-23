-- shift_reg.vhdl
-- CPEG324 - Lab 2

library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
    port(
        I           :   in std_logic_vector (3 downto 0);
        I_SHIFT_IN  :   in std_logic;
        sel         :   in std_logic_vector(1 downto 0); -- 00: load, 01: hold, 10: right shift, 11: left shift
        clock       :   in std_logic;
        enable      :   in std_logic;
        O           :   out std_logic_vector(3 downto 0)
    );
end shift_reg;

architecture struct of shift_reg is

component dff is
    port
	(   
        clk :    in std_logic;
		D   :    in std_logic;
		en  :    in std_logic;
        Q   :    out std_logic
    );
end component dff;

component mux is
    generic (n : integer);
    port (
        A   :    in std_logic_vector (n-1 downto 0);
        B   :    in std_logic_vector (n-1 downto 0);
        C   :    in std_logic_vector (n-1 downto 0);
        D   :    in std_logic_vector (n-1 downto 0);
        sel :    in std_logic_vector (1 downto 0);
        O   :    out std_logic_vector (n-1 downto 0)
    );
end component mux;

signal i0, i1, i2, i3 : std_logic;
signal output: std_logic_vector(3 downto 0) := "0000";

begin
    dff0: dff 
	port map (
        clk => clock,
		D => i0, 
		en => enable, 
		Q => output(0)
	);
	dff1: dff 
	port map (
        clk => clock,
		D => i1,
		en => enable, 
		Q => output(1)
	);
	dff2: dff 
	port map (
        clk => clock,
		D => i2,
		en => enable, 
		Q => output(2)
	);
	dff3: dff 
	port map (
        clk => clock,
		D => i3,
		en => enable, 
		Q => output(3)
	);
    
    mux0: mux 
		generic map (n => 1)
		port map (
			A(0) => output(0), 
			B(0) => output(1), 
			C(0) => I_SHIFT_IN, 
			D(0) => I(0), 
			sel => sel, 
			O(0) => i0
		);
	mux1: mux 
		generic map (n => 1)
		port map (
			A(0) => output(1),
			B(0) => output(2),
			C(0) => output(0), 
			D(0) => I(1), 
			sel => sel, 
			O(0) => i1
		);
	mux2: mux 
		generic map (n => 1) 
		port map (
			A(0) => output(2),
			B(0) => output(3),
			C(0) => output(1),
			D(0) => I(2),
			sel => sel,
			O(0) => i2
		);
	mux3: mux 
		generic map (n => 1)
		port map (
			A(0) => output(3), 
			B(0) => I_SHIFT_IN, 
			C(0) => output(2), 
			D(0) => I(3), 
			sel => sel, 
			O(0) => i3
		);

    O <= output;
    
end struct;