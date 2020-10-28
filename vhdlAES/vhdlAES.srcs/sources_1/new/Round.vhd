library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Round is
  Port ( StateIn: in STD_LOGIC_VECTOR(127 DOWNTO 0);
         StateOut: out STD_LOGIC_VECTOR(127 DOWNTO 0);
         KeyIn: in STD_LOGIC_VECTOR(127 DOWNTO 0);
         KeyOut: out STD_LOGIC_VECTOR(127 DOWNTO 0); 
         RCon: in STD_LOGIC_VECTOR(7 DOWNTO 0));
end Round;

architecture Behavioral of Round is
    component SubBytes is
        Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
               StateOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    
    component ShiftRows is
        Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
               StateOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    component MixColumns is
        Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
               StateOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    component AddRoundKey is
        Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
               key : in STD_LOGIC_VECTOR (127 downto 0);
               StateOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
        
    component ExpandKey is
        Port ( KeyIn : in STD_LOGIC_VECTOR (127 downto 0);
               RCon : in STD_LOGIC_VECTOR (7 downto 0);
               KeyOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    SIGNAL StateSubbed: STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL StateShifted: STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL StateMixed: STD_LOGIC_VECTOR(127 DOWNTO 0);
    
begin
    SB: SubBytes port map(StateIn => StateIn, StateOut => StateSubbed);
    SR: ShiftRows port map(StateIn => StateSubbed, StateOut => StateShifted);
    MC: MixColumns port map(StateIn => StateShifted, StateOut => StateMixed);
    AK: AddRoundKey port map(StateIn => StateMixed, key => KeyIn, StateOut => StateOut);
    
    EK: ExpandKey port map(KeyIn => KeyIn, RCon => RCon, KeyOut => KeyOut);
end Behavioral;
