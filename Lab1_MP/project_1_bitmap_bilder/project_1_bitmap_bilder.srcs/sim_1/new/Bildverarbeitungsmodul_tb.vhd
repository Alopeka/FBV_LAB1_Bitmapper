----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 11:09:42
-- Design Name: 
-- Module Name: Bildverarbeitungsmodul_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Bildverarbeitungsmodul_tb is
end Bildverarbeitungsmodul_tb;

architecture Behavioral of Bildverarbeitungsmodul_tb is

    component top
    port(  
           i_dig_gain : in STD_LOGIC_VECTOR (7 downto 0);
           i_dig_offset : in STD_LOGIC_VECTOR (7 downto 0);
           i_video : in STD_LOGIC_VECTOR (7 downto 0);
           i_clk : in STD_LOGIC;
           i_fval : in STD_LOGIC;
           i_lval : in STD_LOGIC;
           o_video : out STD_LOGIC_VECTOR (7 downto 0);
           o_fval : out STD_LOGIC;
           o_lval : out STD_LOGIC );
    end component;

    signal i_dig_gain : STD_LOGIC_VECTOR (7 downto 0);
    signal i_dig_offset : STD_LOGIC_VECTOR (7 downto 0);
    signal i_video : STD_LOGIC_VECTOR (7 downto 0);
    signal i_clk : STD_LOGIC;
    signal i_fval : STD_LOGIC;
    signal i_lval : STD_LOGIC;
    signal o_video : STD_LOGIC_VECTOR (7 downto 0);
    signal o_fval :  STD_LOGIC;
    signal o_lval :  STD_LOGIC;
        
       
begin

    -- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
   i_dig_gain => i_dig_gain,
   i_dig_offset => i_dig_offset,
   i_video => i_video,
   i_clk => i_clk,
   i_fval => i_fval,
   i_lval => i_lval,
   o_video => o_video,
   o_fval => o_fval,
   o_lval => o_lval
   );

stimulus: process
    begin

    wait;
    end process;

end Behavioral;
