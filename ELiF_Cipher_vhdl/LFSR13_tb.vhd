--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:44:10 02/11/2016
-- Design Name:   
-- Module Name:   D:/Users/adnanb/Desktop/ELF/ELF/LFSR13_tb.vhd
-- Project Name:  ELF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LFSR13
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
 
ENTITY LFSR13_tb IS
END LFSR13_tb;
 
ARCHITECTURE behavior OF LFSR13_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LFSR13
    PORT(
         d_i : IN  std_logic_vector(12 downto 0);
         d_o : OUT  std_logic_vector(12 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal d_i : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal d_o : std_logic_vector(12 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
	
	signal data_reg : std_logic_vector(12 downto 0) := (others => '0');
	
	signal clk : std_logic;
	
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LFSR13 PORT MAP (
          d_i => d_i,
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
 
 reg_process : process(clk)
	begin
		if clk'event and clk = '1' then
			data_reg <= d_o;
		end if;
	end process reg_process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.	
	  d_i(0) <= '1';
      wait for clk_period;
	  d_i <= data_reg;
	  wait for clk_period;
	  d_i <= data_reg;
	  wait for clk_period;
	  d_i <= data_reg;
	  wait for clk_period;
	  d_i <= data_reg;
      -- insert stimulus here 

      wait;
   end process;

END;
