LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY g39_computerFSM IS
port(
	turn, rules, numCheck, clk: in std_logic;
	done, draw : out std_logic;
	counter : buffer std_logic_vector(4 downto 0)
);
end g39_computerFSM;
architecture computerBehaviour of g39_computerFSM is
type state_signal is (A, B, C, D, E );
signal state : state_signal;

begin

state_update : process(clk, turn, rules, numCheck)
	begin
	if turn = '0' then
		state<= A;
	elsif clk'EVENT and clk='1' then
		case state is 
		when A =>
		if turn = '1'then state <= B; end if;
		when B =>
		if rules = '1'then state <= E;
		elsif rules = '0' then state <= C; end if;
		when C =>
		if numCheck = '1'then state<= D; 
		elsif numCheck = '0' then state <= B; end if;
		when D =>
		state <= A;
		when E =>
		state <= A;
	end case;
	end if; --if reset
	end process;
	
output_logic1 : process(state)
	begin
	case state is
		when A => done <='0';
		when B => done <='0';
		when C => done <='0';
		when D => done <='1';
		when E => done <='1';
	end case;
	end process;

output_logic2 : process(state)
	begin
	case state is
		when A => draw <='0';
		when B => draw <='0';
		when C => draw <='0';
		when D => draw <='1';
		when E => draw <='0';
	end case;
	end process;
	
output_logic3 : process(state, counter,clk)
	begin
	if clk'EVENT and clk = '0' then
		case state is
			when A => counter <= "00000";
			when B => counter <= counter;
			when C => counter <= (counter + 1);
			when D => counter <= "00000";
			when E => counter <= "00000";
	end case;
	end if;
	end process;
end computerBehaviour;
	