----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:42:58 02/05/2016 
-- Design Name: 
-- Module Name:    elf_round_c - Behavioral 
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

entity elf_round_c is
	generic(NUM_BITS : natural := 128;
			c : std_logic := '0');
    Port ( d_i : in  STD_LOGIC_VECTOR (NUM_BITS-1 downto 0);
           k   : in  STD_LOGIC;
           d_o : out STD_LOGIC_VECTOR (NUM_BITS-1 downto 0));
end elf_round_c;

architecture Behavioral of elf_round_c is
	component elf_gate_c
		generic(c : std_logic := '0');
		port(
			a1 : in  STD_LOGIC;
			a2 : in  STD_LOGIC;
			x1 : in  STD_LOGIC;
			k  : in  STD_LOGIC;
			d  : out STD_LOGIC
		);
	end component;
	
	component rot_left
		generic(NUM_BITS : natural := 128);
		Port ( d_i : in  STD_LOGIC_VECTOR (NUM_BITS-1 downto 0);
			   d_o : out STD_LOGIC_VECTOR (NUM_BITS-1 downto 0)
		);
	end component;
	
	signal eg_o : std_logic;
	signal rot_i: STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
begin

EGC : elf_gate_c
	generic map (c=>c)
	port map (
	   a1 => d_i(0),
	   a2 => d_i(1),
	   x1 => d_i(2),
	   k  => k,
	   d  => eg_o
	);
	
	rot_i(0) <= d_i(0);
	rot_i(1) <= d_i(1);
	rot_i(2) <= eg_o;
	
RIC : for i in 3 to NUM_BITS-1 generate
	begin
		rot_i(i) <= d_i(i);
	end generate;
	
RLC : rot_left
	generic map(NUM_BITS => NUM_BITS)
	port map(d_i => rot_i, d_o => d_o);

end Behavioral;

