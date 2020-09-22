--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:37:25 02/05/2016
-- Design Name:   
-- Module Name:   D:/Users/adnanb/Desktop/ELF/ELF/elf_round_tb.vhd
-- Project Name:  ELF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: elf_round
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY elf_round_tb IS
END elf_round_tb;
 
ARCHITECTURE behavior OF elf_round_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT elf_round
    PORT(
         d_i : IN  std_logic_vector(63 downto 0);
         k : IN  std_logic;
         c : IN  std_logic;
         d_o : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal d_i : std_logic_vector(63 downto 0) := (others => '0');
   signal k : std_logic := '1';
   signal c : std_logic := '0';

 	--Outputs
   signal d_o : std_logic_vector(63 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
   signal clk : std_logic;
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: elf_round PORT MAP (
          d_i => d_i,
          k => k,
          c => c,
          d_o => d_o
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.

      wait for clk_period;

      -- insert stimulus here 

      wait;
   end process;

END;
