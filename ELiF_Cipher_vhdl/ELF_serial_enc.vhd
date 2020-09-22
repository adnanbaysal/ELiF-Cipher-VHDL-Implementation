----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:54:38 02/11/2016 
-- Design Name: 
-- Module Name:    ELF_serial_enc - Behavioral 
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

-- LFSR final state : 0101110000011

entity ELF_serial_enc is
	generic(datapath : natural := 32;
			NUMBITS	 : natural := 64);
    Port ( p_i : in  STD_LOGIC_VECTOR (datapath-1 downto 0);--plain in 
           k_i : in  STD_LOGIC_VECTOR (datapath-1 downto 0);
           p_r : in  STD_LOGIC;
           k_r : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
		   enc : in STD_LOGIC;
           c_o : out STD_LOGIC_VECTOR (datapath-1 downto 0);
           c_r : out STD_LOGIC);
end ELF_serial_enc;

architecture Behavioral of ELF_serial_enc is
	component elf_round
		generic(NUM_BITS : natural := 64);
		Port ( d_i : in  STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
			   k   : in  STD_LOGIC;
			   c   : in  STD_LOGIC;
			   d_o : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)
		);
	end component;
	
	component LFSR13
    Port ( d_i : in  STD_LOGIC_VECTOR (12 downto 0);
           d_o : out  STD_LOGIC_VECTOR (12 downto 0));
	end component;
	
	signal plain_reg : std_logic_vector(NUMBITS-1 downto 0) := (others => '0');
	signal key_reg : std_logic_vector(2*NUMBITS-1 downto 0) := (others => '0');
	signal lfsr_reg : std_logic_vector(12 downto 0) := (others => '0');
	signal elf_out : std_logic_vector(NUMBITS-1 downto 0);
	signal lfsr_out : std_logic_vector(12 downto 0);
	
begin
	
	process(rst,clk,p_r,k_r,enc)
	begin
		if rst='1' then
			lfsr_reg <= "0000000000001";
			plain_reg <= (others => '0');
			key_reg  <= (others => '0');
		elsif clk'event and clk='1' then
			if k_r = '1' then
				key_reg <= key_reg(2*NUMBITS-1-datapath downto 0) & k_i;
				plain_reg <= plain_reg;
				lfsr_reg <= lfsr_reg;
			elsif p_r = '1' then
				key_reg <= key_reg;
				plain_reg <= plain_reg(NUMBITS-1-datapath downto 0) & p_i;
				lfsr_reg <= lfsr_reg;
			elsif enc = '1' then
				key_reg <= key_reg(2*NUMBITS-2 downto 0) & key_reg(2*NUMBITS-1);
				plain_reg <= elf_out;
				lfsr_reg <= lfsr_out;
			end if;
		end if;
	end process;
	
LF : LFSR13 port map(
		d_i => lfsr_reg,
		d_o => lfsr_out
	);

ER : elf_round port map(
		d_i => plain_reg,
		k   => key_reg(2*NUMBITS-1),
		c   => lfsr_reg(0),
		d_o => elf_out
	);

	c_o <= plain_reg(NUMBITS-1 downto NUMBITS-datapath);
	c_r <= (not lfsr_reg(0)) and lfsr_reg(1) and (not lfsr_reg(2)) and lfsr_reg(3)  and lfsr_reg(4) and lfsr_reg(5) and (not lfsr_reg(6))--0101110
		   and (not lfsr_reg(7)) and (not lfsr_reg(8)) and (not lfsr_reg(9)) and (not lfsr_reg(10)) and lfsr_reg(11) and lfsr_reg(12);--000011
	
end Behavioral;

