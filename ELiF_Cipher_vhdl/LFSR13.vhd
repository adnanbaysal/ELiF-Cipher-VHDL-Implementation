----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:39:10 02/11/2016 
-- Design Name: 
-- Module Name:    LFSR13 - Behavioral 
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

entity LFSR13 is
    Port ( d_i : in  STD_LOGIC_VECTOR (12 downto 0);
           d_o : out  STD_LOGIC_VECTOR (12 downto 0));
end LFSR13;

architecture Behavioral of LFSR13 is
	signal fb : std_logic;
begin

	fb <= d_i(0) xor d_i(1) xor d_i(3) xor d_i(4);
	
shft : for i in 0 to 11 generate
	begin
		d_o(i) <= d_i(i+1);
	end generate;

	d_o(12) <= fb;
	
end Behavioral;

