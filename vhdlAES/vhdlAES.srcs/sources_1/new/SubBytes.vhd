library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SubBytes is
    Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
           StateOut : out STD_LOGIC_VECTOR (127 downto 0));
end SubBytes;

architecture Behavioral of SubBytes is
    component SBox is
    Port ( ByteIn : in STD_LOGIC_VECTOR (7 downto 0);
           ByteOut : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
begin    
    q1:  SBox port map (StateIn((8 *  1) - 1 DOWNTO 8 *  0), StateOut((8 *  1) - 1 DOWNTO 8 *  0));
    q2:  SBox port map (StateIn((8 *  2) - 1 DOWNTO 8 *  1), StateOut((8 *  2) - 1 DOWNTO 8 *  1));
    q3:  SBox port map (StateIn((8 *  3) - 1 DOWNTO 8 *  2), StateOut((8 *  3) - 1 DOWNTO 8 *  2));
    q4:  SBox port map (StateIn((8 *  4) - 1 DOWNTO 8 *  3), StateOut((8 *  4) - 1 DOWNTO 8 *  3));
    q5:  SBox port map (StateIn((8 *  5) - 1 DOWNTO 8 *  4), StateOut((8 *  5) - 1 DOWNTO 8 *  4));
    q6:  SBox port map (StateIn((8 *  6) - 1 DOWNTO 8 *  5), StateOut((8 *  6) - 1 DOWNTO 8 *  5));
    q7:  SBox port map (StateIn((8 *  7) - 1 DOWNTO 8 *  6), StateOut((8 *  7) - 1 DOWNTO 8 *  6));
    q8:  SBox port map (StateIn((8 *  8) - 1 DOWNTO 8 *  7), StateOut((8 *  8) - 1 DOWNTO 8 *  7));
    q9:  SBox port map (StateIn((8 *  9) - 1 DOWNTO 8 *  8), StateOut((8 *  9) - 1 DOWNTO 8 *  8));
    q10: SBox port map (StateIn((8 * 10) - 1 DOWNTO 8 *  9), StateOut((8 * 10) - 1 DOWNTO 8 *  9));
    q11: SBox port map (StateIn((8 * 11) - 1 DOWNTO 8 * 10), StateOut((8 * 11) - 1 DOWNTO 8 * 10));
    q12: SBox port map (StateIn((8 * 12) - 1 DOWNTO 8 * 11), StateOut((8 * 12) - 1 DOWNTO 8 * 11));
    q13: SBox port map (StateIn((8 * 13) - 1 DOWNTO 8 * 12), StateOut((8 * 13) - 1 DOWNTO 8 * 12));
    q14: SBox port map (StateIn((8 * 14) - 1 DOWNTO 8 * 13), StateOut((8 * 14) - 1 DOWNTO 8 * 13));
    q15: SBox port map (StateIn((8 * 15) - 1 DOWNTO 8 * 14), StateOut((8 * 15) - 1 DOWNTO 8 * 14));
    q16: SBox port map (StateIn((8 * 16) - 1 DOWNTO 8 * 15), StateOut((8 * 16) - 1 DOWNTO 8 * 15));
    
end Behavioral;
