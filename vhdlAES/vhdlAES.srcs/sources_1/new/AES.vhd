library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AES is
    Port ( clk, reset, en: in STD_LOGIC;
           ByteIn: in STD_LOGIC_VECTOR(7 DOWNTO 0);
           CypherText: out STD_LOGIC_VECTOR(127 DOWNTO 0));
end AES;

architecture Behavioral of AES is
    component Controller is
        Port ( clk : in STD_LOGIC;
               DataByte : in STD_LOGIC_VECTOR (7 downto 0);
               reset : in STD_LOGIC;
               en : in STD_LOGIC;
               ByteOut : out STD_LOGIC_VECTOR (7 downto 0);
               ByteReady : out STD_LOGIC;
               BlockReady : out STD_LOGIC); 
    end component;
    
    component ShiftReg is
        Generic(Width: INTEGER := 128);
        Port ( clk: in STD_LOGIC;
               en: in STD_LOGIC;
               SerialIn: in STD_LOGIC_VECTOR(7 DOWNTO 0);
               DataOut: out    STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0));
    end component;
    
    component AESCore is
        Port ( PlainText : in STD_LOGIC_VECTOR (127 downto 0);
               key : in STD_LOGIC_VECTOR (127 downto 0);
               CypherText : out STD_LOGIC_VECTOR (127 downto 0);
               Counter: in STD_LOGIC_VECTOR(4 DOWNTO 0);
               en, clk, s: in STD_LOGIC);
    end component;
    SIGNAL SerialByte: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ByteReady: STD_LOGIC;
    SIGNAL BlockReady: STD_LOGIC;
    SIGNAL PlainTextAndKey: STD_LOGIC_VECTOR(255 DOWNTO 0);
    SIGNAL Counter: STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s: STD_LOGIC;
    SIGNAL FinalRound: STD_LOGIC;
begin
    s <= '0' when (Counter = B"00000") else '1';
    FinalRound <= '1' when Counter = B"01010" else '0';
    process (clk, reset) begin 
        if (reset = '1') then
            Counter <= B"00000";
        elsif (BlockReady = '1') then
            if (rising_edge(clk)) then
                if (Counter /= B"01010") then
                    Counter <= STD_LOGIC_VECTOR(UNSIGNED(Counter) + 1);
                end if;
            end if;
        end if; 
    end process;
    MainController: Controller port map(
        clk => clk, en => en, reset => reset,
        DataByte => ByteIn, ByteOut => SerialByte,
        ByteReady => ByteReady, BlockReady => BlockReady 
    );
    
    DataKeyReg: ShiftReg generic map(256) port map(
        clk => clk, 
        en => (ByteReady AND (NOT BlockReady)),
        SerialIn => SerialByte,
        DataOut => PlainTextAndKey
    );
    
    Core: AESCore port map(
        PlainText => PlainTextAndKey(127 DOWNTO 0),
        key => PlainTextAndKey(255 DOWNTO 128),
        CypherText => CypherText, en => BlockReady  AND (NOT FinalRound),
        clk => clk, s => s, Counter => Counter
    );
end Behavioral;
