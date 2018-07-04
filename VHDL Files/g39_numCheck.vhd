LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY g39_numCheck IS
port(
	userNum, dealerNum, compNum : in std_logic_vector(5 downto 0);
	userEmpty, compEmpty, dealerEmpty, userSeven, compSeven: out std_logic
);
end g39_numCheck;
architecture numCheck of g39_numCheck is
Begin

	process (userNum, dealerNum, compNum)
		Begin

		if userNum = "000000" then userEmpty <= '1';
		else userEmpty <= '0'; 
		end if;

		if compNum = "000000" then compEmpty <= '1';
		else compEmpty <= '0';
		end if;

		if dealerNum = "000000" then dealerEmpty <= '1';
		else dealerEmpty <= '0';
		end if;

	end process;

	process (userNum, dealerNum, compNum)
		Begin

		if userNum = "000110" then userSeven <= '1';
		else userSeven <= '0';
		end if;

		if compNum = "000110" then compSeven <= '1'; 
		else compSeven <= '0';
		end if;

	end process;

end numCheck;