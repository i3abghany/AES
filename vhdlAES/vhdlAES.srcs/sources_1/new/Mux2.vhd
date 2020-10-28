library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2 is
    Generic(WIDTH: INTEGER := 128);
    Port (a0 : in STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
          a1 : in STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
          s : in STD_LOGIC;
          y : out STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0)); 
end Mux2;

architecture Behavioral of Mux2 is

begin
    with s select
    y <= a0 when '0',
         a1 when others; 

end Behavioral;
