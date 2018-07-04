LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY g39_playPile IS
port(
	userMode, compMode : in std_logic_vector (1 downto 0);
	dealerToPile, reset : in std_logic;
	userPoppedValue, compPoppedValue, dealerPoppedValue :  in std_logic_vector (5 downto 0);
	play_pile_top_card : buffer std_logic_vector(5 downto 0)
);
end g39_playPile;

architecture playPile of g39_playPile is
begin

	process(userMode, compMode, dealerToPile, reset, userPoppedValue, compPoppedValue, dealerPoppedValue, play_pile_top_card)
	begin
		if reset = '1' then
			play_pile_top_card <= "000000";
		
		elsif userMode = "11" then
			play_pile_top_card <= userPoppedValue;
		
		elsif compMode = "11" then
			play_pile_top_card <= compPoppedValue;
		
		elsif dealerToPile = '1' then
			play_pile_top_card <= dealerPoppedValue;
		
		else
			play_pile_top_card <= play_pile_top_card;
		end if;
	end process;

end playPile;