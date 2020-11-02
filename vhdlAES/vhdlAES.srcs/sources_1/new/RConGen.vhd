library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RConGen is
    Port ( RoundCount : in STD_LOGIC_VECTOR (4 downto 0);
           RCon : out STD_LOGIC_VECTOR (7 downto 0));
end RConGen;

architecture Behavioral of RConGen is

begin    
    process (all) begin 
        case (RoundCount) is
            when B"00000" => RCon <= X"02";
            when B"00001" => RCon <= X"04";
            when B"00010" => RCon <= X"08";
            when B"00011" => RCon <= X"10";
            when B"00100" => RCon <= X"20";
            when B"00101" => RCon <= X"40";
            when B"00110" => RCon <= X"80";
            when B"00111" => RCon <= X"1b";
            when B"01000" => RCon <= X"36";
            when others => RCon <= X"00"; 
        end case;
    end process;
end Behavioral;
