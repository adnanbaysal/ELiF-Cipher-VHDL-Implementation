----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:33 02/05/2016 
-- Design Name: 
-- Module Name:    lat1_elf_round_c - Behavioral 
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

entity lat1_elf_round_c is
	generic(NUM_BITS: natural := 128;
			c		: std_logic_vector(0 to 125) := (others => '0'));
    Port ( 	d_i 	: in  STD_LOGIC_VECTOR (NUM_BITS-1 downto 0);
			k 		: in  STD_LOGIC_VECTOR (NUM_BITS-3 downto 0);
			d_o 	: out STD_LOGIC_VECTOR (NUM_BITS-1 downto 0));
end lat1_elf_round_c;

architecture Behavioral of lat1_elf_round_c is
	component elf_round_c
		generic(NUM_BITS : natural := 128;
				c		 : std_logic := '0');
		Port ( d_i : in  STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
			   k   : in  STD_LOGIC;
			   d_o : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)
		);
	end component;
	
	signal round_out : std_logic_vector(0 to (NUM_BITS-1)*NUM_BITS-1);
begin
	
	round_out(0 to NUM_BITS-1) <= d_i;

R_loop : for i in 0 to NUM_BITS-3 generate
	begin
		NLERC : elf_round_c
			generic map(NUM_BITS => NUM_BITS, c => c(i))
			port map(
				d_i => round_out(i*NUM_BITS to (i+1)*NUM_BITS-1),
				k   => k(i),
				d_o => round_out((i+1)*NUM_BITS to (i+2)*NUM_BITS-1)
			);
	end generate;

	d_o <= round_out((NUM_BITS-2)*NUM_BITS to (NUM_BITS-1)*NUM_BITS-1);

end Behavioral;

