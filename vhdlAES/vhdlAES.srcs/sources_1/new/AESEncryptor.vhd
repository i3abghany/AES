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
           CypherText : out STD_LOGIC_VECTOR (127 downto 0));
end AESEncryptor;

architecture Struct of AESEncryptor is

begin


end Struct;
