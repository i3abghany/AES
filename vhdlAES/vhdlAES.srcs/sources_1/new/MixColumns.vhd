library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MixColumns is
    Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
           StateOut : out STD_LOGIC_VECTOR (127 downto 0));
end MixColumns;

architecture Behavioral of MixColumns is
    component MixColWord is
    Port ( WordIn : in STD_LOGIC_VECTOR (31 downto 0);
           WordOut : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    subtype FirstWord  is INTEGER RANGE (32 * 1) - 1 DOWNTO (32 * 0);
    subtype SecondWord is INTEGER RANGE (32 * 2) - 1 DOWNTO (32 * 1);
    subtype ThirdWord  is INTEGER RANGE (32 * 3) - 1 DOWNTO (32 * 2);
    subtype FourthWord is INTEGER RANGE (32 * 4) - 1 DOWNTO (32 * 3); 
begin
    M1: MixColWord port map(WordIn => StateIn(FirstWord),  WordOut => StateOut(FirstWord));
    M2: MixColWord port map(WordIn => StateIn(SecondWord), WordOut => StateOut(SecondWord));
    M3: MixColWord port map(WordIn => StateIn(ThirdWord),  WordOut => StateOut(ThirdWord));
    M4: MixColWord port map(WordIn => StateIn(FourthWord), WordOut => StateOut(FourthWord));
end Behavioral;
