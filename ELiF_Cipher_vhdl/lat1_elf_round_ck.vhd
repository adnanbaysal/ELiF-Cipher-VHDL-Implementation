----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:47:48 02/05/2016 
-- Design Name: 
-- Module Name:    lat1_elf_round_ck - Behavioral 
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

entity lat1_elf_round_ck is
	generic(NUM_BITS: natural := 64;
			c		: std_logic_vector(0 to 61) := (others => '0');
			k		: std_logic_vector(0 to 61) := (others => '0'));
    Port ( d_i : in  STD_LOGIC_VECTOR (NUM_BITS-1 downto 0);
           d_o : out STD_LOGIC_VECTOR (NUM_BITS-1 downto 0));
end lat1_elf_round_ck;

architecture Behavioral of lat1_elf_round_ck is
	component elf_round_ck
		generic(NUM_BITS : natural := 64;
				c		 : std_logic := '0';
				k		 : std_logic := '0');
		Port ( d_i : in  STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
			   d_o : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)
		);
	end component;
	
	signal round_out : std_logic_vector(0 to (NUM_BITS-1)*NUM_BITS-1);
begin

	round_out(0 to NUM_BITS-1) <= d_i;

R_loop : for i in 0 to NUM_BITS-3 generate
	begin
		NLERC : elf_round_ck
			generic map(NUM_BITS => NUM_BITS, c => c(i), k => k(i))
			port map(
				d_i => round_out(i*NUM_BITS to (i+1)*NUM_BITS-1),
				d_o => round_out((i+1)*NUM_BITS to (i+2)*NUM_BITS-1)
			);
	end generate;

	d_o <= round_out((NUM_BITS-2)*NUM_BITS to (NUM_BITS-1)*NUM_BITS-1);

end Behavioral;

