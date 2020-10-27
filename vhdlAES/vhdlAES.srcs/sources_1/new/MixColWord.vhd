library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MixColWord is
    Port ( WordIn : in STD_LOGIC_VECTOR (31 downto 0);
           WordOut : out STD_LOGIC_VECTOR (31 downto 0));
end MixColWord;

architecture Behavioral of MixColWord is
    component GMul2 is
    Port ( ByteIn : in STD_LOGIC_VECTOR (7 downto 0);
           ByteOut : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component GMul3 is
    Port ( ByteIn : in STD_LOGIC_VECTOR (7 downto 0);
           ByteOut : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    subtype FirstByte  is INTEGER RANGE (8 * 1) - 1 DOWNTO (8 * 0);
    subtype SecondByte is INTEGER RANGE (8 * 2) - 1 DOWNTO (8 * 1);
    subtype ThirdByte  is INTEGER RANGE (8 * 3) - 1 DOWNTO (8 * 2);
    subtype FourthByte is INTEGER RANGE (8 * 4) - 1 DOWNTO (8 * 3);
    
    -- Mul(Multiplicand)_(ByteNumber)
    SIGNAL Mul1_1: STD_LOGIC_VECTOR(7 DOWNTO 0);  
    SIGNAL Mul2_1: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Mul3_1: STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    SIGNAL Mul1_2: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Mul2_2: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Mul3_2: STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    SIGNAL Mul1_3: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Mul2_3: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Mul3_3: STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    SIGNAL Mul1_4: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Mul2_4: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Mul3_4: STD_LOGIC_VECTOR(7 DOWNTO 0);
     
begin
    Mul1_1 <= WordIn(FirstByte);
    Mul1_2 <= WordIn(SecondByte);
    Mul1_3 <= WordIn(ThirdByte);
    Mul1_4 <= WordIn(FourthByte); 
    
    G1: GMul2 port map(ByteIn => WordIn(FirstByte),  ByteOut => Mul2_1);
    G2: GMul2 port map(ByteIn => WordIn(SecondByte), ByteOut => Mul2_2);
    G3: GMul2 port map(ByteIn => WordIn(ThirdByte),  ByteOut => Mul2_3);
    G4: GMul2 port map(ByteIn => WordIn(FourthByte), ByteOut => Mul2_4);
    
    G5: GMul3 port map(ByteIn => WordIn(FirstByte),  ByteOut => Mul3_1);
    G6: GMul3 port map(ByteIn => WordIn(SecondByte), ByteOut => Mul3_2);
    G7: GMul3 port map(ByteIn => WordIn(ThirdByte),  ByteOut => Mul3_3);
    G8: GMul3 port map(ByteIn => WordIn(FourthByte), ByteOut => Mul3_4);
    
    WordOut(FirstByte)  <= Mul2_1 XOR Mul3_2 XOR Mul1_3 XOR Mul1_4;
    WordOut(SecondByte) <= Mul1_1 XOR Mul2_2 XOR Mul3_3 XOR Mul1_4;
    WordOut(ThirdByte)  <= Mul1_1 XOR Mul1_2 XOR Mul2_3 XOR Mul3_4;
    WordOut(FourthByte) <= Mul3_1 XOR Mul1_2 XOR Mul1_3 XOR Mul2_4;
end Behavioral;
