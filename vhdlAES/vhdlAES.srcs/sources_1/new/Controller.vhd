library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controller is
    Port ( clk : in STD_LOGIC;
           DataByte : in STD_LOGIC_VECTOR (7 downto 0);
           reset : in STD_LOGIC;
           en : in STD_LOGIC;
           ByteOut : out STD_LOGIC_VECTOR (7 downto 0);
           ByteReady : out STD_LOGIC;
           BlockReady : out STD_LOGIC); 
end Controller;

architecture Behavioral of Controller is
    TYPE State is (IDLE, RECEIVE, OPERATE);
    SIGNAL CurrentState, NextState: State;
    SIGNAL Counter: STD_LOGIC_VECTOR(5 DOWNTO 0);
begin
    
    process(clk, reset) begin
        if (reset = '1') then
            CurrentState <= IDLE;
        elsif rising_edge(clk) then
            CurrentState <= NextState;
        end if;
    end process;
    
    -- Next State Logic.
    process (all) begin
        case CurrentState is
            when IDLE => 
                if (en = '1') then
                    NextState <= RECEIVE;
                else
                    NextState <= IDLE;
                end if;
            when RECEIVE => 
                if (Counter = B"011111") then
                    NextState <= OPERATE;
                else 
                    NextState <= RECEIVE;
                end if;
            when OPERATE => 
                NextState <= OPERATE;
        end case;
    end process;
    
    process(clk, reset) begin
        if (reset = '1') then
            Counter <= B"000000";
        elsif (rising_edge(clk)) then
            if (NextState = RECEIVE) then
                Counter <= STD_LOGIC_VECTOR(UNSIGNED(Counter) + 1);
            end if;
        end if;
    end process;
    
    -- Output Logic.
    process(CurrentState, NextState, Counter, DataByte) begin
        case (CurrentState) is 
            when IDLE => 
                ByteOut <= X"00";
                ByteReady <= '0';
                BlockReady <= '0';
            when RECEIVE => 
                ByteOut <= DataByte;
                ByteReady <= '1';
                BlockReady <= '0';
            when OPERATE => 
                ByteOut <= X"FF";
                BlockReady <= '1';
                ByteReady <= '1';
        end case;
    end process;
end Behavioral;
