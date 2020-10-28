library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AESCoreTB is
end AESCoreTB;

architecture Behavioral of AESCoreTB is
    component AESCore is
        Port ( PlainText : in STD_LOGIC_VECTOR (127 downto 0);
               key : in STD_LOGIC_VECTOR (127 downto 0);
               CypherText : out STD_LOGIC_VECTOR (127 downto 0);
               en, clk : in STD_LOGIC);
    end component;
    SIGNAL TestKey: STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL TestData: STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL Cypherd: STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL clk: STD_LOGIC;
begin
    DUT: AESCore port map(PlainText => TestData, key => TestKey, CypherText => Cypherd, en => '1', clk => clk);
    TestKey <= X"5468617473206D79204B756E67204675";
    TestData <= X"54776F204F6E65204E696E652054776F";
end Behavioral;
