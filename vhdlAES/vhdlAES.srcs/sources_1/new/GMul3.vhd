library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GMul3 is
    Port ( ByteIn : in STD_LOGIC_VECTOR (7 downto 0);
           ByteOut : out STD_LOGIC_VECTOR (7 downto 0));
end GMul3;

architecture Behavioral of GMul3 is
    component GMul2 is
        Port ( ByteIn : in STD_LOGIC_VECTOR (7 downto 0);
               ByteOut : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    SIGNAL Mul2: STD_LOGIC_VECTOR(7 DOWNTO 0); 
begin
    M: GMul2 port map(ByteIn => ByteIn, ByteOut => Mul2);
    ByteOut <= Mul2 XOR ByteIn;
end Behavioral;
