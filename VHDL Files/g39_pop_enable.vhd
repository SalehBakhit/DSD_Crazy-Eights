-- this circuit implements pop enable circuit
--
-- entity name: g39_RANDU
--
-- Copyright (C) 2017 Saleh Bakhit, Adham El-Khouly
-- Version 1.0
-- Author: Saleh Bakhit (saleh.bakhit@mail.mcgill.ca), Adham El-Khouly (adham.el-khouly@mail.mcgill.ca)
-- Date: 13/02/2017

LIBRARY lpm;
library ieee;
USE lpm.lpm_components.all;
USE ieee.std_logic_1164.all;



entity g39_pop_enable is
port ( N : in std_logic_vector(5 downto 0);
P_EN : out std_logic_vector(51 downto 0);
clk : in std_logic);
end g39_pop_enable;

architecture behavior_pop_enable of g39_pop_enable is


Begin
crc_table : lpm_rom -- use the altera rom library macrocell
GENERIC MAP(
lpm_widthad => 6, -- sets the width of the ROM address bus
lpm_numwords => 64, -- sets the number of words stored in the ROM
lpm_outdata => "UNREGISTERED", -- no register on the output
lpm_address_control => "REGISTERED", -- register on the input
lpm_file => "g39_LUTcontent.mif", -- the ascii file containing the ROM data
lpm_width => 52) -- the width of the word stored in each ROM location
PORT MAP(inclock => clk, address => N, q => P_EN);


end behavior_pop_enable;