----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:12:43 02/05/2016 
-- Design Name: 
-- Module Name:    elf_gate_ck - Behavioral 
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
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity elf_gate_ck is
	generic(c :std_logic := '0';
			k : std_logic := '0');
    Port ( a1 : in  STD_LOGIC;
           a2 : in  STD_LOGIC;
           x1 : in  STD_LOGIC;
           d : out  STD_LOGIC);
end elf_gate_ck;

architecture Behavioral of elf_gate_ck is
	--signal cc: std_logic_vector(0 downto 0);
	--signal kk: std_logic_vector(0 downto 0);
begin

	--cc <= CONV_STD_LOGIC_VECTOR(c,1);
	--kk <= CONV_STD_LOGIC_VECTOR(k,1);
	--d <= (a1 and a2) xor x1 xor kk(0) xor cc(0);
	d <= (a1 and a2) xor x1 xor k xor c;
	
end Behavioral;

