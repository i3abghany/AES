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
           en, clk : in STD_LOGIC);
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
    
    component Reg is
        Generic (WIDTH: INTEGER := 128);
        Port ( clk, en : in STD_LOGIC;
               d : in STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
               q : out STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0));
    end component;
    
    CONSTANT WIDTH: INTEGER := 128;
    SIGNAL InitialKeyAdd: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateS0: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateK0: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK0A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS1: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK1: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateS1A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK1A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS2: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK2: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateS2A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK2A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS3: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK3: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateS3A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK3A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS4: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK4: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateS4A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK4A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS5: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK5: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateS5A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK5A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS6: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK6: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateS6A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK6A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS7: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK7: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateS7A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK7A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS8: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK8: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateS8A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK8A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS9: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK9: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateS9A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK9A: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    
    SIGNAL IntermediateS10: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
begin
    A1: AddRoundKey port map(StateIn => PlainText, key => key, StateOut => InitialKeyAdd);
    E1: ExpandKey port map(KeyIn => Key, RCon => X"01", KeyOut => IntermediateK0);
    
    PKReg1: Reg generic map(WIDTH) port map(
        d => IntermediateK0, en => en,
        q => IntermediateK0A, clk => clk 
    );
    
    PSReg1: Reg generic map(WIDTH) port map(
        d => InitialKeyAdd, en => en,
        q => IntermediateS0, clk => clk 
    );
    
    R1: Round port map(
        StateIn => IntermediateS0, 
        StateOut => IntermediateS1, 
        KeyIn => IntermediateK0A, 
        KeyOut => IntermediateK1, 
        RCon => X"02");
    
    PKReg2: Reg generic map(WIDTH) port map(
        d => IntermediateK1, en => en,
        q => IntermediateK1A, clk => clk 
    );
    
    PSReg2: Reg generic map(WIDTH) port map(
        d => IntermediateS1, en => en,
        q => IntermediateS1A, clk => clk 
    );
    
    R2: Round port map(
        StateIn => IntermediateS1A, 
        StateOut => IntermediateS2, 
        KeyIn => IntermediateK1A, 
        KeyOut => IntermediateK2, 
        RCon => X"04");
    
    PKReg3: Reg generic map(WIDTH) port map(
        d => IntermediateK2, en => en,
        q => IntermediateK2A, clk => clk 
    );
    
    PSReg3: Reg generic map(WIDTH) port map(
        d => IntermediateS2, en => en,
        q => IntermediateS2A, clk => clk 
    );

    R3: Round port map(
        StateIn => IntermediateS2A, 
        StateOut => IntermediateS3, 
        KeyIn => IntermediateK2A, 
        KeyOut => IntermediateK3, 
        RCon => X"08");
    
    PKReg4: Reg generic map(WIDTH) port map(
        d => IntermediateK3, en => en,
        q => IntermediateK3A, clk => clk 
    );
    
    PSReg4: Reg generic map(WIDTH) port map(
        d => IntermediateS3, en => en,
        q => IntermediateS3A, clk => clk 
    );
    
    R4: Round port map(
        StateIn => IntermediateS3A, 
        StateOut => IntermediateS4, 
        KeyIn => IntermediateK3A, 
        KeyOut => IntermediateK4, 
        RCon => X"10");
        
   PKReg5: Reg generic map(WIDTH) port map(
        d => IntermediateK4, en => en,
        q => IntermediateK4A, clk => clk 
    );
    
    PSReg5: Reg generic map(WIDTH) port map(
        d => IntermediateS4, en => en,
        q => IntermediateS4A, clk => clk 
    );
    
    R5: Round port map(
        StateIn => IntermediateS4A, 
        StateOut => IntermediateS5, 
        KeyIn => IntermediateK4A, 
        KeyOut => IntermediateK5, 
        RCon => X"20");
    
    PKReg6: Reg generic map(WIDTH) port map(
        d => IntermediateK5, en => en,
        q => IntermediateK5A, clk => clk 
    );
    
    PSReg6: Reg generic map(WIDTH) port map(
        d => IntermediateS5, en => en,
        q => IntermediateS5A, clk => clk 
    );
    
    R6: Round port map(
        StateIn => IntermediateS5A, 
        StateOut => IntermediateS6, 
        KeyIn => IntermediateK5A, 
        KeyOut => IntermediateK6, 
        RCon => X"40");

    PKReg7: Reg generic map(WIDTH) port map(
        d => IntermediateK6, en => en,
        q => IntermediateK6A, clk => clk 
    );
    
    PSReg7: Reg generic map(WIDTH) port map(
        d => IntermediateS6, en => en,
        q => IntermediateS6A, clk => clk 
    );
            
    R7: Round port map(
        StateIn => IntermediateS6A, 
        StateOut => IntermediateS7, 
        KeyIn => IntermediateK6A, 
        KeyOut => IntermediateK7, 
        RCon => X"80");
    
    PKReg8: Reg generic map(WIDTH) port map(
        d => IntermediateK7, en => en,
        q => IntermediateK7A, clk => clk 
    );
    
    PSReg8: Reg generic map(WIDTH) port map(
        d => IntermediateS7, en => en,
        q => IntermediateS7A, clk => clk 
    );
    
    R8: Round port map(
        StateIn => IntermediateS7A, 
        StateOut => IntermediateS8, 
        KeyIn => IntermediateK7A, 
        KeyOut => IntermediateK8, 
        RCon => X"1b");

    PKReg9: Reg generic map(WIDTH) port map(
        d => IntermediateK8, en => en,
        q => IntermediateK8A, clk => clk 
    );
    
    PSReg9: Reg generic map(WIDTH) port map(
        d => IntermediateS8, en => en,
        q => IntermediateS8A, clk => clk 
    );
        
    R9: Round port map(
        StateIn => IntermediateS8A, 
        StateOut => IntermediateS9, 
        KeyIn => IntermediateK8A, 
        KeyOut => IntermediateK9, 
        RCon => X"36");

    PKReg10: Reg generic map(WIDTH) port map(
        d => IntermediateK9, en => en,
        q => IntermediateK9A, clk => clk 
    );
    
    PSReg10: Reg generic map(WIDTH) port map(
        d => IntermediateS9, en => en,
        q => IntermediateS9A, clk => clk 
    );
        
    R10: LastRound port map(
        StateIn => IntermediateS9A, 
        StateOut => IntermediateS10, 
        KeyIn => IntermediateK9A);
    
    PSReg11: Reg generic map(WIDTH) port map(
        d => IntermediateS10, en => en,
        q => CypherText, clk => clk 
    );
        
end Struct;
