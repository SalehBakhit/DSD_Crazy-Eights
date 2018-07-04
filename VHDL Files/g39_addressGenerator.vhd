LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY g39_addressGenerator IS
port(
	selector : in std_logic_vector (1 downto 0);
	reset : in std_logic;
	userAddress : buffer std_logic_vector(5 downto 0);
	clk : in std_logic

);
end g39_addressGenerator;

architecture behaviour of g39_addressGenerator is

begin

	process(selector, userAddress, reset, clk)
	begin

		if reset = '1' then
			userAddress <= "000000";
		elsif clk'EVENT and clk='1' then
			if selector = "00" AND userAddress > "000000" then
			userAddress <= userAddress - 1;
			elsif selector = "10" AND userAddress < "011010" then
			userAddress <= userAddress + 1;
			else
			userAddress <= userAddress;
		end if;
		
	end if;
	
	end process;
	
end behaviour;