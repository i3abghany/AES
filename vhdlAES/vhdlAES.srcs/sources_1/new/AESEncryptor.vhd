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

entity AESEncryptor is
    Port ( PlainText : in STD_LOGIC_VECTOR (127 downto 0);
           key : in STD_LOGIC_VECTOR (127 downto 0);
           CypherText : out STD_LOGIC_VECTOR (127 downto 0);
           en : in STD_LOGIC);
end AESEncryptor;

architecture Struct of AESEncryptor is
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

    
    CONSTANT WIDTH: INTEGER := 128;
    SIGNAL InitailKeyAdd: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK0: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS1: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK1: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS2: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK2: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS3: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK3: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS4: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK4: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS5: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK5: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS6: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK6: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS7: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK7: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS8: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK8: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS9: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    SIGNAL IntermediateK9: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
    
    SIGNAL IntermediateS10: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
begin
    A1: AddRoundKey port map(StateIn => PlainText, key => key, StateOut => InitailKeyAdd);
    E1: ExpandKey port map(KeyIn => Key, RCon => X"01", KeyOut => IntermediateK0);
    R1: Round port map(
        StateIn => InitailKeyAdd, 
        StateOut => IntermediateS1, 
        KeyIn => IntermediateK0, 
        KeyOut => IntermediateK1, 
        RCon => X"02");
        
    R2: Round port map(
        StateIn => IntermediateS1, 
        StateOut => IntermediateS2, 
        KeyIn => IntermediateK1, 
        KeyOut => IntermediateK2, 
        RCon => X"04");

    R3: Round port map(
        StateIn => IntermediateS2, 
        StateOut => IntermediateS3, 
        KeyIn => IntermediateK2, 
        KeyOut => IntermediateK3, 
        RCon => X"08");
            
    R4: Round port map(
        StateIn => IntermediateS3, 
        StateOut => IntermediateS4, 
        KeyIn => IntermediateK3, 
        KeyOut => IntermediateK4, 
        RCon => X"10");
        
    R5: Round port map(
        StateIn => IntermediateS4, 
        StateOut => IntermediateS5, 
        KeyIn => IntermediateK4, 
        KeyOut => IntermediateK5, 
        RCon => X"20");
        
    R6: Round port map(
        StateIn => IntermediateS5, 
        StateOut => IntermediateS6, 
        KeyIn => IntermediateK5, 
        KeyOut => IntermediateK6, 
        RCon => X"40");
        
    R7: Round port map(
        StateIn => IntermediateS6, 
        StateOut => IntermediateS7, 
        KeyIn => IntermediateK6, 
        KeyOut => IntermediateK7, 
        RCon => X"80");
                
    R8: Round port map(
        StateIn => IntermediateS7, 
        StateOut => IntermediateS8, 
        KeyIn => IntermediateK7, 
        KeyOut => IntermediateK8, 
        RCon => X"1b");
                
    R9: Round port map(
        StateIn => IntermediateS8, 
        StateOut => IntermediateS9, 
        KeyIn => IntermediateK8, 
        KeyOut => IntermediateK9, 
        RCon => X"36");
                
    R10: LastRound port map(
        StateIn => IntermediateS9, 
        StateOut => CypherText, 
        KeyIn => IntermediateK9);
end Struct;
