LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY g39_controlFSM IS
port(
	userDraw, rules, userEmpty, compEmpty, dealerEmpty, userSeven, compSeven, done, reset, draw, clk, play, Stack_En: in std_logic;
	control : out std_logic_vector(10 downto 0)
);
end g39_controlFSM;
architecture computerBehaviour of g39_controlFSM is
type state_signal is (A, B, C, D, E, F, G , H, I, J, K, L, M, N, O, P, Q, R, S, T, U );
signal state : state_signal;

begin
state_update : process(clk, rules, userEmpty, compEmpty, dealerEmpty, userSeven, compSeven, done, draw, reset, play)
	begin
	if reset = '0'  then
		state <= A;
	elsif clk'EVENT and clk='1' then
		case state is 
		when A =>
		if reset = '1' then state <= c; end if;
		when C =>
		state <= D; 
		when D =>
		if Stack_En = '1' then state <= E;
		elsif Stack_En = '0' then state <= D; end if;
		when E =>
		if userSeven = '0' then state <= D; 
		elsif userSeven = '1' then state <= F; end if;
		when F =>
		if Stack_En = '1' then state <= G;
		elsif Stack_En = '0' then state <= F; end if;
		when G =>
		if compSeven = '0' then state <= F; 
		elsif compSeven = '1' then state <= H; end if;
		when H =>
		state <= I;
		when I =>
		if done = '0' then state <= I; 
		elsif done = '1' then state <= p; end if;
		when J =>
		if play = '0' then state <= N; 
		elsif userDraw = '0' then state <= O; end if;
		when K =>
		state <= J;
		when L =>
		state <= U;
		when M =>
		state <= M;
		when N =>
		if rules = '0' then state <= K; 
		elsif rules = '1' then state <= L; end if;
		when O =>
		if Stack_En = '1' then state <= B;
		elsif Stack_En = '0' then state <= O; end if;
		when B =>
		state <= U;
		when P =>
		if draw = '1'then state <= Q; 
		elsif draw = '0' then state <= R; end if;
		when Q =>
		if Stack_En = '1' then state <= S;
		elsif Stack_En = '0' then state <= Q; end if;
		when R =>
		state <= T;
		when S =>
		state <= T;
		when T =>
		if (userEmpty OR compEmpty OR dealerEmpty) = '1' then state <= M;
		elsif (userEmpty OR compEmpty OR dealerEmpty) = '0' then state <= J; end if;
		when U =>
		if (userEmpty OR compEmpty OR dealerEmpty) = '1' then state <= M;
		elsif (userEmpty OR compEmpty OR dealerEmpty) = '0' then state <= I; end if;
		
		
	end case;
	end if; --if reset
	end process;
	-- dealerToPile(10), Request_Deal(9), turn(8), userMode(7..6), compMode(5..4), dealerMode(3..2), validPlay(1), gameOver(0)
output_logic : process(state)
	begin
	case state is
		when A => control <= "01000000000"; -- nothing
		when C => control <= "01000001000"; -- Initialize dealer's deck
		when D => control <= "00000001100"; -- Request a card from dealer's deck 
		when E => control <= "01001000000"; -- Push to player's deck
		when F => control <= "00000001100"; -- Pop dealer's deck
		when G => control <= "01000010000"; -- Push comp's deck
		when H => control <= "10000001100"; -- Pop pile
		when I => control <= "01100000000"; -- Computer's turn
		when J => control <= "01000000000"; -- Player's turn
		when K => control <= "01000000000"; -- Invalid player card
		when L => control <= "01011000010"; -- Pop player's deck
		when M => control <= "01000000001"; -- Gamer over
		when N => control <= "01000000000"; -- Player didnt draw a card
		when O => control <= "00000001100"; -- Player requested to draw
		when B => control <= "01001000000"; -- Push to user's deck
		when P => control <= "01100000000"; -- buffer
		when Q => control <= "00100001100"; -- Pop dealer's deck
		when R => control <= "01100110000"; -- pop comp's deck
		when S => control <= "01100010000"; -- Push to comp's deck
		when T => control <= "01000000000"; -- check for winner
		when U => control <= "01000000000"; -- check for winner
	end case;
	end process;

end computerBehaviour;
	