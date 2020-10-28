library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRows is
    Port ( StateIn : in STD_LOGIC_VECTOR (127 DOWNTO 0);
           StateOut : out STD_LOGIC_VECTOR (127 DOWNTO 0));
end ShiftRows;

architecture Behavioral of ShiftRows is
    
begin
    StateOut((8 *  16) - 1 DOWNTO 8 * 15) <= StateIn((8 * 16) - 1 DOWNTO 8 * 15);
    StateOut((8 *  15) - 1 DOWNTO 8 * 14) <= StateIn((8 * 11) - 1 DOWNTO 8 * 10);
    StateOut((8 *  14) - 1 DOWNTO 8 * 13) <= StateIn((8 *  6) - 1 DOWNTO 8 *  5);
    StateOut((8 *  13) - 1 DOWNTO 8 * 12) <= StateIn((8 *  1) - 1 DOWNTO 8 *  0);
    
    StateOut((8 *  12) - 1 DOWNTO 8 * 11) <= StateIn((8 * 12) - 1 DOWNTO 8 * 11);
    StateOut((8 *  11) - 1 DOWNTO 8 * 10) <= StateIn((8 *  7) - 1 DOWNTO 8 *  6);
    StateOut((8 *  10) - 1 DOWNTO 8 *  9) <= StateIn((8 *  2) - 1 DOWNTO 8 *  1);
    StateOut((8 *   9) - 1 DOWNTO 8 *  8) <= StateIn((8 * 13) - 1 DOWNTO 8 * 12);
    
    StateOut((8 *  8) - 1 DOWNTO 8 *  7) <= StateIn((8 *  8) - 1 DOWNTO 8 *  7);
    StateOut((8 *  7) - 1 DOWNTO 8 *  6) <= StateIn((8 *  3) - 1 DOWNTO 8 *  2);
    StateOut((8 *  6) - 1 DOWNTO 8 *  5) <= StateIn((8 * 14) - 1 DOWNTO 8 * 13);
    StateOut((8 *  5) - 1 DOWNTO 8 *  4) <= StateIn((8 *  9) - 1 DOWNTO 8 *  8);
    
    StateOut((8 *  4) - 1 DOWNTO 8 *  3) <= StateIn((8 *  4) - 1 DOWNTO 8 *  3);
    StateOut((8 *  3) - 1 DOWNTO 8 *  2) <= StateIn((8 * 15) - 1 DOWNTO 8 * 14);
    StateOut((8 *  2) - 1 DOWNTO 8 *  1) <= StateIn((8 * 10) - 1 DOWNTO 8 *  9);
    StateOut((8 *  1) - 1 DOWNTO 8 *  0) <= StateIn((8 *  5) - 1 DOWNTO 8 *  4);

end Behavioral;
