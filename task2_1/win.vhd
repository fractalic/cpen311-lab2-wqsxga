LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
LIBRARY WORK;
USE WORK.ALL;

--------------------------------------------------------------
--
--  Check three roulette bets against the a spin of a
--  roulette wheel to see which bets win.
--
---------------------------------------------------------------

ENTITY win IS
	PORT(spin_result_latched : in unsigned(5 downto 0);  -- result of the spin (the winning number)
             bet1_value : in unsigned(5 downto 0); -- value for bet 1
             bet2_colour : in std_logic;  -- colour for bet 2
             bet3_dozen : in unsigned(1 downto 0);  -- dozen for bet 3
             bet1_wins : out std_logic;  -- whether bet 1 is a winner
             bet2_wins : out std_logic;  -- whether bet 2 is a winner
             bet3_wins : out std_logic); -- whether bet 3 is a winner
END win;


ARCHITECTURE behavioural OF win IS
-- Store the dozen in which the result lies.
signal spin_result_dozen : unsigned(1 downto 0);
BEGIN
	-- Check for wins on bet 1 (straight-up).
	process(bet1_value)
	begin
		if (bet1_value = spin_result_latched) then
			bet1_wins <= '1';
		else
			bet1_wins <= '0';
		end if;
	end process;
	
	-- Check for wins on bet 3 (dozen).
	process(bet3_dozen)
	begin
		-- Determine which dozen contains the result.
		if (spin_result_latched < 24) then
			if (spin_result_latched < 12) then
				if (spin_result_latched > 0) then
					spin_result_dozen <= "00";
				end if;
			else
				spin_result_dozen <= "01";
			end if;
		else
			spin_result_dozen <= "10";
		end if;
		
		if (bet3_dozen = spin_result_dozen) then
			bet3_wins <= '1';
		else
			bet3_wins <= '0';
		end if;
		
	end process;
	
END;
