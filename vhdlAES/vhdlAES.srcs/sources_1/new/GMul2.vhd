library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GMul2 is
    Port ( ByteIn : in STD_LOGIC_VECTOR (7 downto 0);
           ByteOut : out STD_LOGIC_VECTOR (7 downto 0));
end GMul2;

architecture Behavioral of GMul2 is
    SIGNAL ShiftedByte: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL XORByte: STD_LOGIC_VECTOR(7 DOWNTO 0);
begin
    ShiftedByte <= ByteIn(6 DOWNTO 0) & "0";
    XORByte <= "000" & ByteIn(7) & ByteIn(7) & "0" & ByteIn(7) & ByteIn(7);
    ByteOut <= ShiftedByte XOR XORByte; 
end Behavioral;
