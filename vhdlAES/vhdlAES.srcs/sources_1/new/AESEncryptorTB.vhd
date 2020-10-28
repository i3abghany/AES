library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AESEncryptorTB is
end AESEncryptorTB;

architecture Behavioral of AESEncryptorTB is
    component AESEncryptor is
        Port ( PlainText : in STD_LOGIC_VECTOR (127 downto 0);
               key : in STD_LOGIC_VECTOR (127 downto 0);
               CypherText : out STD_LOGIC_VECTOR (127 downto 0);
               en : in STD_LOGIC);
    end component;
    SIGNAL TestKey: STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL TestData: STD_LOGIC_VECTOR(127 DOWNTO 0);
    SIGNAL Cypherd: STD_LOGIC_VECTOR(127 DOWNTO 0);
begin
    DUT: AESEncryptor port map(PlainText => TestData, key => TestKey, CypherText => Cypherd, en => '1');
    TestKey <= X"5468617473206D79204B756E67204675";
    TestData <= X"54776F204F6E65204E696E652054776F";
end Behavioral;
