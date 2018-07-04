library IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity g39_dealerFSM is
port (
	Request_Deal : in std_logic;
	RAND_LT_NUM : in std_logic;
	clock : in std_logic;
	RAND_Enable : out std_logic;
	Stack_Enable : out std_logic
);
end g39_dealerFSM;

architecture dealerBehaviour of g39_dealerFSM is
type state_signal is (A, B, C);
signal state : state_signal;

begin

state_update : process(clock, Request_Deal, RAND_LT_NUM)
	begin
	if request_Deal = '1' then
		state<= A;
	elsif clock'EVENT and clock='1' then
		case state is 
		when A =>
		if request_Deal = '0' then state <= B; end if;
		when B =>
		if RAND_LT_NUM = '0' then state <= B;
		elsif RAND_LT_NUM = '1' then state <= C; end if;
		when C =>
		state <= A;
	end case;
	end if; --if reset
	end process;
	
output_logic1 : process(state)
	begin
	case state is
		when A => RAND_Enable <='0';
		when B => RAND_Enable <='1';
		when C => RAND_Enable <='0';
	end case;
	end process;

output_logic2 : process(state)
	begin
	case state is
		when A => Stack_Enable <='0';
		when B => Stack_Enable <='0';
		when C => Stack_Enable <='1';
	end case;
	end process;
end dealerBehaviour;