library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
  Generic (WIDTH: INTEGER := 128);
  Port ( clk, reset, en: in STD_LOGIC;
         d: in STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
         q: out STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0));
end Reg;

architecture Behavioral of Reg is

begin
    process (clk, reset, en) begin
        if (reset = '1') then
            q <= (others => '0');
        elsif (rising_edge(clk)) then
            if (en = '1') then 
                q <= d;
            end if;
        end if;
    end process;
end Behavioral;
