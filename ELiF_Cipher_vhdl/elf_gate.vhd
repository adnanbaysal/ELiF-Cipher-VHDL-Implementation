----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:45:54 02/05/2016 
-- Design Name: 
-- Module Name:    elf_gate - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity elf_gate is
    Port ( a1 : in  STD_LOGIC;
           a2 : in  STD_LOGIC;
           x1 : in  STD_LOGIC;
           k  : in  STD_LOGIC;
           c  : in  STD_LOGIC;
           d  : out STD_LOGIC);
end elf_gate;

architecture Behavioral of elf_gate is

begin

	d <= (a1 and a2) xor x1 xor k xor c;

end Behavioral;

