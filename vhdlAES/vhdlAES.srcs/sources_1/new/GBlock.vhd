library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GBlock is
    Port ( WordIn : in STD_LOGIC_VECTOR (31 downto 0);
           WordOut : out STD_LOGIC_VECTOR (31 downto 0);
           RCon : in STD_LOGIC_VECTOR (7 downto 0));
end GBlock;

architecture Behavioral of GBlock is
    SIGNAL IntermediateW: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SubbedW: STD_LOGIC_VECTOR(31 DOWNTO 0);
    component SBox is 
        Port ( ByteIn : in STD_LOGIC_VECTOR (7 downto 0);
               ByteOut : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
begin
    IntermediateW <= WordIn((3 * 8) - 1 DOWNTO (0 * 8)) & WordIn((4 * 8) - 1 DOWNTO (3 * 8));
    
    q1: SBox port map(IntermediateW((8 * 1) - 1 DOWNTO 8 * 0), SubbedW((8 * 1) - 1 DOWNTO 8 * 0));
    q2: SBox port map(IntermediateW((8 * 2) - 1 DOWNTO 8 * 1), SubbedW((8 * 2) - 1 DOWNTO 8 * 1));
    q3: SBox port map(IntermediateW((8 * 3) - 1 DOWNTO 8 * 2), SubbedW((8 * 3) - 1 DOWNTO 8 * 2));
    q4: SBox port map(IntermediateW((8 * 4) - 1 DOWNTO 8 * 3), SubbedW((8 * 4) - 1 DOWNTO 8 * 3));
    
    WordOut <= (SubbedW((8 * 4) - 1 DOWNTO (8 * 3)) XOR RCON) & (SubbedW ((8 * 3) - 1 DOWNTO 0));
end Behavioral;
