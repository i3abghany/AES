library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControllerTB is
end ControllerTB;

architecture Behavioral of ControllerTB is
    SIGNAL clk : STD_LOGIC;
    SIGNAL DataByte: STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL reset: STD_LOGIC;
    SIGNAL en : STD_LOGIC;
    SIGNAL ByteOut: STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL ByteReady: STD_LOGIC;
    SIGNAL BlockReady: STD_LOGIC; 
    
    component Controller is
    Port ( clk : in STD_LOGIC;
           DataByte : in STD_LOGIC_VECTOR (7 downto 0);
           reset : in STD_LOGIC;
           en : in STD_LOGIC;
           ByteOut : out STD_LOGIC_VECTOR (7 downto 0);
           ByteReady : out STD_LOGIC;
           BlockReady : out STD_LOGIC); 
    end component;

begin
        DUT: Controller port map(clk => clk, DataByte => DataByte, reset => reset, 
                             en => en, ByteOut => ByteOut, ByteReady => ByteReady,
                             BlockReady => BlockReady);
    process begin
        clk <= '1';
        wait for 100ns;
        clk <= '0';
        wait for 100ns;
    end process;
    
    process begin
    reset <= '1';
    wait for 100ns;
    reset <= '0';
    en <= '1';
    
    DataByte <= X"DE";
    wait for 200ns;
    DataByte <= X"AD";
    wait for 200ns;
    DataByte <= X"BE";
    wait for 200ns;
    DataByte <= X"EF";
    wait for 200ns;
    
    DataByte <= X"AC";
    wait for 200ns;
    DataByte <= X"DC";
    wait for 200ns;
    DataByte <= X"EF";
    wait for 200ns;
    DataByte <= X"DD";
    
    DataByte <= X"AA";
    wait for 200ns;
    DataByte <= X"BB";
    wait for 200ns;
    DataByte <= X"CC";
    wait for 200ns;
    DataByte <= X"DD";
    wait for 200ns;
    
    DataByte <= X"3A";
    wait for 200ns;
    DataByte <= X"2B";
    wait for 200ns;
    DataByte <= X"69";
    wait for 200ns;
    DataByte <= X"42";
    wait;
    
    end process;
end Behavioral;