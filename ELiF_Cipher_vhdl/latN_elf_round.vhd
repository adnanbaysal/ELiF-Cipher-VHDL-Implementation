----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:51:51 02/05/2016 
-- Design Name: 
-- Module Name:    latN_elf_round - Behavioral 
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

entity latN_elf_round is
	generic(NUM_BITS : natural := 64;
			LAT		 : natural := 16);
    Port ( d_i : in  STD_LOGIC_VECTOR (NUM_BITS-1 downto 0);
           k : in  STD_LOGIC_VECTOR (LAT*(NUM_BITS-2)-1 downto 0);
           c : in  STD_LOGIC_VECTOR (LAT*(NUM_BITS-2)-1 downto 0);
           d_o : out  STD_LOGIC_VECTOR (NUM_BITS-1 downto 0));
end latN_elf_round;

architecture Behavioral of latN_elf_round is
	component lat1_elf_round
		generic(NUM_BITS : natural := 64);
		Port ( d_i : in  STD_LOGIC_VECTOR (NUM_BITS-1 downto 0);
			   k   : in  STD_LOGIC_VECTOR (NUM_BITS-3 downto 0);
			   c   : in  STD_LOGIC_VECTOR (NUM_BITS-3 downto 0);
			   d_o : out STD_LOGIC_VECTOR (NUM_BITS-1 downto 0)
		);
	end component;
	
	signal lat1_out : std_logic_vector(0 to (LAT+1)*NUM_BITS-1);
begin

	lat1_out(0 to NUM_BITS-1) <= d_i;
	
L_loop : for i in 0 to LAT-1 generate
	begin
		L1ER : lat1_elf_round
			generic map(NUM_BITS => NUM_BITS)
			port map(
				d_i => lat1_out(i*NUM_BITS to (i+1)*NUM_BITS-1),
				k   => k((LAT-i)*(NUM_BITS-2)-1 downto (LAT-i-1)*(NUM_BITS-2)),
				c   => c((LAT-i)*(NUM_BITS-2)-1 downto (LAT-i-1)*(NUM_BITS-2)),
				d_o => lat1_out((i+1)*NUM_BITS to (i+2)*NUM_BITS-1)
			);
	end generate;

	d_o <= lat1_out(LAT*NUM_BITS to (LAT+1)*NUM_BITS-1);

end Behavioral;

