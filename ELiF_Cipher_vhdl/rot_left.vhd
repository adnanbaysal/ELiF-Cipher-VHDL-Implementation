----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:48:28 02/05/2016 
-- Design Name: 
-- Module Name:    rot_left - Behavioral 
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

entity rot_left is
	generic(NUM_BITS : natural := 128);
    Port ( d_i : in  STD_LOGIC_VECTOR (NUM_BITS-1 downto 0);
           d_o : out STD_LOGIC_VECTOR (NUM_BITS-1 downto 0));
end rot_left;

architecture Behavioral of rot_left is

begin

rotate_by_1:
   for i in 0 to NUM_BITS-2 generate
      begin
         d_o(i+1) <= d_i(i);
   end generate;

   d_o(0) <= d_i(NUM_BITS-1);
   
end Behavioral;

