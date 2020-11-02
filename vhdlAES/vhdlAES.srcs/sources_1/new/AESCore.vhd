----------------------------------------------------------------------------------
-- Engineer: Mahmoud Abd Al-Ghany 
-- 
-- Create Date: 10/26/2020 01:07:08 AM
-- Design Name: 
-- Module Name: AESEncryptor - Struct
-- Project Name: vhdlAES
-- Tool Versions: Vivado 2019.1
-- Description: The top level module of the AES encryptor module.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AESCore is
    Port ( PlainText : in STD_LOGIC_VECTOR (127 downto 0);
           key : in STD_LOGIC_VECTOR (127 downto 0);
           CypherText : out STD_LOGIC_VECTOR (127 downto 0);
           Counter: in STD_LOGIC_VECTOR(4 DOWNTO 0);
           en, clk, s: in STD_LOGIC);
end AESCore;

architecture Struct of AESCore is
    component AddRoundKey is
        Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
               key : in STD_LOGIC_VECTOR (127 downto 0);
               StateOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    component Round is
      Port ( StateIn: in STD_LOGIC_VECTOR(127 DOWNTO 0);
             StateOut: out STD_LOGIC_VECTOR(127 DOWNTO 0);
             KeyIn: in STD_LOGIC_VECTOR(127 DOWNTO 0);
             KeyOut: out STD_LOGIC_VECTOR(127 DOWNTO 0); 
             RCon: in STD_LOGIC_VECTOR(7 DOWNTO 0));
    end component;
    
    component LastRound is 
        Port ( StateIn : in STD_LOGIC_VECTOR (127 downto 0);
               StateOut : out STD_LOGIC_VECTOR (127 downto 0);
               KeyIn : in STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    component ExpandKey is
        Port ( KeyIn : in STD_LOGIC_VECTOR (127 downto 0);
               RCon : in STD_LOGIC_VECTOR (7 downto 0);
               KeyOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    component Mux2 is
        Generic(WIDTH: INTEGER := 128);
        Port (a0 : in STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
              a1 : in STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
              s : in STD_LOGIC;
              y : out STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0)); 
    end component;
    
    component Reg is
        Generic (WIDTH: INTEGER := 128);
        Port ( clk, en : in STD_LOGIC;
               d : in STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
               q : out STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0));
    end component;
    
    component RConGen is
        Port ( RoundCount : in STD_LOGIC_VECTOR (4 downto 0);
               RCon : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    CONSTANT WIDTH: INTEGER := 128;
    SIGNAL InitialKeyAdd: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK0: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS1: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK1: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        
    SIGNAL IntermediateState: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL PrevRoundKey: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL PrevRoundState: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL KeyInput: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL StateInput: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL RCon: STD_LOGIC_VECTOR(7 DOWNTO 0);
begin

    A1: AddRoundKey port map(StateIn => PlainText, key => key, StateOut => InitialKeyAdd);
    E1: ExpandKey port map(KeyIn => Key, RCon => X"01", KeyOut => IntermediateK0);
    
    M1: Mux2 port map(a0 => IntermediateK0, a1 => PrevRoundKey, s => s, y => KeyInput);
    M2: Mux2 port map(a0 => InitialKeyAdd, a1 => PrevRoundState, s => s, y => StateInput);

    RCG: RConGen port map(RoundCount => Counter, RCon => RCon);
        
    R1: Round port map(
        StateIn => StateInput, 
        StateOut => IntermediateS1, 
        KeyIn => KeyInput, 
        KeyOut => IntermediateK1, 
        RCon => RCon);
    
    PKReg2: Reg generic map(WIDTH) port map(
        d => IntermediateK1, en => en,
        q => PrevRoundKey, clk => clk 
    );
    
    PSReg2: Reg generic map(WIDTH) port map(
        d => IntermediateS1, en => en,
        q => PrevRoundState, clk => clk 
    );
        
    R2: LastRound port map(
        StateIn => PrevRoundState, 
        StateOut => IntermediateState, 
        KeyIn => PrevRoundKey);
    
    PSReg11: Reg generic map(WIDTH) port map(
        d => IntermediateState, en => en,
        q => CypherText, clk => clk 
    );
        
end Struct;
