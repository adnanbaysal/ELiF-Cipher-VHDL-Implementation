----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:34:31 02/05/2016 
-- Design Name: 
-- Module Name:    latN_elf_round_c - Behavioral 
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

-- len(c) = LAT*(NUM_BITS-2)

entity latN_elf_round_c is
	generic(NUM_BITS: natural := 128;
			LAT		: natural := 8;
			c	 	: std_logic_vector(0 to 8*126-1) := (others => '0'));
    Port ( d_i 		: in  STD_LOGIC_VECTOR (NUM_BITS-1 downto 0);
           k 		: in  STD_LOGIC_VECTOR (LAT*(NUM_BITS-2)-1 downto 0);
           d_o 		: out STD_LOGIC_VECTOR (NUM_BITS-1 downto 0));
end latN_elf_round_c;

architecture Behavioral of latN_elf_round_c is
	component lat1_elf_round_c
		generic(NUM_BITS: natural := 128;
				c		: std_logic_vector(0 to 125) := (others => '0')
		);
		Port ( d_i : in  STD_LOGIC_VECTOR (NUM_BITS-1 downto 0);
			   k   : in  STD_LOGIC_VECTOR (NUM_BITS-3 downto 0);
			   d_o : out STD_LOGIC_VECTOR (NUM_BITS-1 downto 0)
		);
	end component;
	
	signal lat1_out : std_logic_vector(0 to (LAT+1)*NUM_BITS-1);
begin

	lat1_out(0 to NUM_BITS-1) <= d_i;
	
L_loop : for i in 0 to LAT-1 generate
	begin
		L1ERC : lat1_elf_round_c
			generic map(NUM_BITS => NUM_BITS,c => c((LAT-i-1)*(NUM_BITS-2) to (LAT-i)*(NUM_BITS-2)-1))
			port map(
				d_i => lat1_out(i*NUM_BITS to (i+1)*NUM_BITS-1),
				k   => k((LAT-i)*(NUM_BITS-2)-1 downto (LAT-i-1)*(NUM_BITS-2)),
				d_o => lat1_out((i+1)*NUM_BITS to (i+2)*NUM_BITS-1)
			);
	end generate;

	d_o <= lat1_out(LAT*NUM_BITS to (LAT+1)*NUM_BITS-1);

end Behavioral;

