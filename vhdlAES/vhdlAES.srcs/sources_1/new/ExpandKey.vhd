library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ExpandKey is
    Port ( KeyIn : in STD_LOGIC_VECTOR (127 downto 0);
           RCon : in STD_LOGIC_VECTOR (7 downto 0);
           KeyOut : out STD_LOGIC_VECTOR (127 downto 0));
end ExpandKey;

architecture Behavioral of ExpandKey is
    component GBlock is
    Port ( WordIn : in STD_LOGIC_VECTOR (31 downto 0);
           WordOut : out STD_LOGIC_VECTOR (31 downto 0);
           RCon : in STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    subtype FirstWord  is INTEGER RANGE (32 * 1) - 1 DOWNTO (32 * 0);
    subtype SecondWord is INTEGER RANGE (32 * 2) - 1 DOWNTO (32 * 1);
    subtype ThirdWord  is INTEGER RANGE (32 * 3) - 1 DOWNTO (32 * 2);
    subtype FourthWord is INTEGER RANGE (32 * 4) - 1 DOWNTO (32 * 3);
    
    SIGNAL GWord: STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    SIGNAL XORW1: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL XORW2: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL XORW3: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL XORW4: STD_LOGIC_VECTOR(31 DOWNTO 0);
begin
    G: GBlock port map(WordIn => KeyIn(FourthWord), WordOut => GWord, RCon => RCon);
    
    XORW1 <= GWord XOR KeyIn(FirstWord);
    XORW2 <= XORW1 XOR KeyIn(SecondWord);
    XORW3 <= XORW2 XOR KeyIn(ThirdWord);
    XORW4 <= XORW3 XOR KeyIn(FourthWord);
    
    KeyOut <= XORW1 & XORW2 & XORW3 & XORW4;
end Behavioral;
