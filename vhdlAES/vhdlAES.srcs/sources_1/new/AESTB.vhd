library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AESTB is
end AESTB;

architecture Behavioral of AESTB is
    component AES is
        Port ( clk, reset, en: in STD_LOGIC;
               ByteIn: in STD_LOGIC_VECTOR(7 DOWNTO 0);
               CypherText: out STD_LOGIC_VECTOR(127 DOWNTO 0));
    end component;
    
    SIGNAL clk, reset, en: STD_LOGIC;
    SIGNAL ByteIn: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL CypherText: STD_LOGIC_VECTOR(127 DOWNTO 0); 
begin
    DUT: AES port map(
        clk, reset, en, ByteIn, CypherText
    );
    
    process begin
        clk <= '1';
        wait for 50ns;
        clk <= '0';
        wait for 50ns;
    end process;
    
    process begin
        ByteIn <= X"00";
        reset <= '1';
        en <= '0';
        wait for 50ns;
        reset <= '0';
        en <= '1';
        wait for 100ns;
        ByteIn <= X"6F";
        
        wait for 100ns;
        ByteIn <= X"77";
        
        wait for 100ns;
        ByteIn <= X"54";
        
        wait for 100ns;
        ByteIn <= X"20";
        
        wait for 100ns;
        ByteIn <= X"65";
    
        wait for 100ns;
        ByteIn <= X"6E";
    
        wait for 100ns;
        ByteIn <= X"69";
        
        wait for 100ns;
        ByteIn <= X"4E";

        wait for 100ns;
        ByteIn <= X"20";
        
        wait for 100ns;
        ByteIn <= X"65";
    
        wait for 100ns;
        ByteIn <= X"6E";
        
        wait for 100ns;
        ByteIn <= X"4F";
    
        wait for 100ns;
        ByteIn <= X"20";
        
        wait for 100ns;
        ByteIn <= X"6F";
    
        wait for 100ns;
        ByteIn <= X"77";
    
        wait for 100ns;
        ByteIn <= X"54";
    
        wait for 100ns;
        ByteIn <= X"75";
        
        wait for 100ns;
        ByteIn <= X"46";
    
        wait for 100ns;
        ByteIn <= X"20";
        
        wait for 100ns;
        ByteIn <= X"67";
        
        wait for 100ns;
        ByteIn <= X"6E";
        
        wait for 100ns;
        ByteIn <= X"75";
        
        wait for 100ns;
        ByteIn <= X"4B";
        
        wait for 100ns;
        ByteIn <= X"20";
        
        wait for 100ns;
        ByteIn <= X"79";
        
        wait for 100ns;
        ByteIn <= X"6D";
        
        wait for 100ns;
        ByteIn <= X"20";
        
        wait for 100ns;
        ByteIn <= X"73";
        
        wait for 100ns;
        ByteIn <= X"74";
        
        wait for 100ns;
        ByteIn <= X"61";
        
        wait for 100ns;
        ByteIn <= X"68";
        
        wait for 100ns;
        ByteIn <= X"54";
        wait;
    end process;

end Behavioral;
