LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity g39_rules is
port (
	play_pile_top_card : in std_logic_vector(5 downto 0);
	card_to_play : in std_logic_vector(5 downto 0);
	legal_play : out std_logic
);
end g39_rules;

architecture rules of g39_rules is

component g39_Modulo_13 is
port(	
A : in std_logic_vector (5 downto 0);
Amod13 : out std_logic_vector (3 downto 0);
Floor13: out std_logic_vector (2 downto 0);
GO : out std_logic_vector (8 downto 0);
SUM : out std_logic_vector (8 downto 0));
end component g39_Modulo_13;

signal pileCardFV : std_logic_vector (3 downto 0);
signal playCardFV : std_logic_vector (3 downto 0);
signal pileCardSuit : std_logic_vector (2 downto 0);
signal playCardSuit : std_logic_vector (2 downto 0);

signal temp1 : std_logic_vector (3 downto 0);
signal temp2 : std_logic_vector (3 downto 0);


Begin
inst0: g39_Modulo_13 port map (play_pile_top_card,temp1,pileCardSuit);

inst1: g39_Modulo_13 port map (card_to_play,temp2,playCardSuit);

playCardFV <= temp1 + 1;
pileCardFV <= temp2 + 1;

process (playCardFV, pileCardFV, playCardSuit, pileCardSuit)
Begin
	if playCardFV = "1000" then
		legal_play <= '1';
	elsif pileCardFV = "1000" then
		legal_play <= '1';
	elsif playCardFV = pileCardFV then
		legal_play <= '1';
	elsif playCardSuit = pileCardSuit then
		legal_play <= '1';
	else 
		legal_play <= '0';
	end if;
end process;
	
End rules;