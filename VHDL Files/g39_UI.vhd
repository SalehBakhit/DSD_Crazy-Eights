LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity g39_UI is
port(
	displaySelect : in std_logic_vector(3 downto 0);
	play_pile_top_card : in std_logic_vector(5 downto 0);
	userValue : in std_logic_vector(5 downto 0);
	userNum, dealerNum, compNum : in std_logic_vector(5 downto 0);
	turn, valid, gameOver : in std_logic;
	displayCard : out std_logic_vector(5 downto 0);
	displayNumbers1 : out unsigned(5 downto 0);
	displayNumbers2 : out unsigned(5 downto 0)
);
end g39_UI;

architecture interface of g39_UI is

signal floor_result, mod_result : integer;
begin

	process(displaySelect, play_pile_top_card, userValue, userNum, dealerNum,
				compNum, turn, valid, gameOver)
	begin
		if displaySelect = "0000" then
			displayCard <= play_pile_top_card;
			displayNumbers1 <= "000000";
			displayNumbers2 <= "000000";
		
		elsif displaySelect = "0001" then
			displayCard <= userValue;
			displayNumbers1 <= "000000";
			displayNumbers2 <= "000000";
		
		elsif displaySelect = "0010" then
			displayCard <= "001001";
		   floor_result <= to_integer(unsigned(userNum))/10;
			mod_result <= to_integer(unsigned(userNum)) mod 10;
			displayNumbers1 <= to_unsigned(floor_result,6);
			displayNumbers2 <= to_unsigned(mod_result,6);

		elsif displaySelect = "0011" then
			displayCard <= "001001";
			floor_result <= to_integer(unsigned(compNum))/10;
			mod_result <= to_integer(unsigned(compNum)) mod 10;
			displayNumbers1 <= to_unsigned(floor_result,6);
			displayNumbers2 <= to_unsigned(mod_result,6);

		
		elsif displaySelect = "0100" then
			displayCard <= "001001";
			floor_result <= to_integer(unsigned(dealerNum))/10;
			mod_result <= to_integer(unsigned(dealerNum)) mod 10;
			displayNumbers1 <= to_unsigned(floor_result,6);
			displayNumbers2 <= to_unsigned(mod_result,6);
		
		elsif displaySelect = "0101" then
			displayCard <= "001001";
			displayNumbers1 <= "001010";
			displayNumbers2 <= "00000" & turn;
		
		elsif displaySelect = "0110" then
			displayCard <= "001001";
			displayNumbers1 <= "001011";
			displayNumbers2 <= "00000" & NOT valid;
		
		elsif displaySelect = "0111" then
			displayCard <= "001001";
			displayNumbers1 <= "001100";
			displayNumbers2 <= "00000" & gameOver;
		
		elsif displaySelect = "1000" then
			if gameOver = '1' then
				if dealerNum = "000000" then
					displayCard <= "001001";
					displayNumbers1 <= "001101";
					displayNumbers2 <= "001101" ;
				
				elsif compNum = "000000" then
					displayCard <= "001001";
					displayNumbers1 <= "001111";
					displayNumbers2 <= "000001" ;
					
				elsif userNum = "000000" then
					displayCard <= "001001";
					displayNumbers1 <= "001111";
					displayNumbers2 <= "000000" ;
				else
				displayCard <= "001001";
				displayNumbers1 <= "000000";
				displayNumbers2 <= "000000" ;
				end if;
			else
				displayCard <= "001001";
				displayNumbers1 <= "000000";
				displayNumbers2 <= "000000" ;
			end if;
				
		end if;
		
	end process;
	
end interface;