library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftReg is
  Generic(Width: INTEGER := 128);
  Port ( clk: in STD_LOGIC;
         en: in STD_LOGIC;
         SerialIn: in STD_LOGIC_VECTOR(7 DOWNTO 0);
         DataOut: out STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0));
end ShiftReg;

architecture Behavioral of ShiftReg is
    SIGNAL Data: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
begin
    process (clk, en) begin
        if (rising_edge(clk)) then
            if (en = '1') then
                Data <= SerialIn & Data(WIDTH - 1 DOWNTO 8);
            end if;
        end if;
    end process;
    
end Behavioral;
