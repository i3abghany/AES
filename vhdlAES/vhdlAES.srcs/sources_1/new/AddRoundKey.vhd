library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AddRoundKey is
    Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
           key : in STD_LOGIC_VECTOR (127 downto 0);
           StateOut : out STD_LOGIC_VECTOR (127 downto 0));
end AddRoundKey;

architecture Behavioral of AddRoundKey is

begin
    StateOut <= StateIn XOR key;
end Behavioral;
