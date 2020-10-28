library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LastRound is
    Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
           StateOut : out STD_LOGIC_VECTOR (127 downto 0);
           KeyIn : in STD_LOGIC_VECTOR (127 downto 0));
end LastRound;

architecture Behavioral of LastRound is
    component SubBytes is
        Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
               StateOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    component ShiftRows is
        Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
               StateOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    component AddRoundKey is
        Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
               key : in STD_LOGIC_VECTOR (127 downto 0);
               StateOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    SIGNAL StateSubbed: STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL StateShifted: STD_LOGIC_VECTOR(127 DOWNTO 0);
begin
    SB: SubBytes port map(StateIn => StateIn, StateOut => StateSubbed);
    SR: ShiftRows port map(StateIn => StateSubbed, StateOut => StateShifted);
    AK: AddRoundKey port map(StateIn => StateShifted, key => KeyIn, StateOut => StateOut);
end Behavioral;
