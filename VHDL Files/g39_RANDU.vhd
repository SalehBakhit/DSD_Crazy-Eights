-- this circuit implements the IBM RANDU version of a linear congruential generator
--
-- entity name: g39_RANDU
--
-- Copyright (C) 2017 Saleh Bakhit, Adham El-Khouly
-- Version 1.0
-- Author: Saleh Bakhit (saleh.bakhit@mail.mcgill.ca), Adham El-Khouly (adham.el-khouly@mail.mcgill.ca)
-- Date: 13/02/2017

LIBRARY ieee; --allows use of the std_logic_vectortype
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY g39_RANDU IS
PORT( 
	seed : IN std_logic_vector (31 DOWNTO 0);
	rand : OUT std_logic_vector (31 DOWNTO 0)
);
END g39_RANDU;

ARCHITECTURE RANDU OF g39_RANDU IS

SIGNAL seed_shifted_16 : std_logic_vector (47 DOWNTO 0);
SIGNAL seed_shifted_1 : std_logic_vector (32 DOWNTO 0);
SIGNAL output_of_mul : std_logic_vector (47 DOWNTO 0);

BEGIN

seed_shifted_16	<= (seed & "0000000000000000");
seed_shifted_1		<= (seed & "0");
output_of_mul	<= seed + seed_shifted_1 + seed_shifted_16 + 1;
rand <= ("0" & output_of_mul(30 DOWNTO 0));


END RANDU;