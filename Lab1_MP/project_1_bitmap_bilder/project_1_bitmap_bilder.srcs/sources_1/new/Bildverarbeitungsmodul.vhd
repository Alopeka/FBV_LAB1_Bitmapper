----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 11:07:34
-- Design Name: 
-- Module Name: top - Behavioral
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

use work.fbv_pkg.all;

entity top is
    Port ( i_dig_gain : in STD_LOGIC_VECTOR (7 downto 0);
           i_dig_offset : in STD_LOGIC_VECTOR (7 downto 0);
           i_video : in STD_LOGIC_VECTOR (7 downto 0);
           i_clk : in STD_LOGIC;
           i_fval : in STD_LOGIC;
           i_lval : in STD_LOGIC;
           o_video : out STD_LOGIC_VECTOR (7 downto 0);
           o_fval : out STD_LOGIC;
           o_lval : out STD_LOGIC);
end top;

architecture Behavioral of top is

    
    signal i_fval_intern: std_logic;
    signal i_lval_intern: std_logic;
    signal  i_video_intern: std_logic_vector ( 7 downto 0);
    signal zwSP: std_logic_vector(7 downto 0);
    signal outVideoTemp: std_logic_vector(7 downto 0);
    signal d_lval1, d_fval1: std_logic :='0';
begin
    sync_input: process(i_clk)  -- sinnloser Prozess ? aber Ack hat gemeint... Ack fragen warum wir machen sollten
        begin --Prozess zu Taltsynchronisation der synchronen Eingäng
            if falling_edge(i_clk) then
                i_fval_intern <= i_fval;
                i_lval_intern <= i_lval;
                i_video_intern <=  i_video; 
                o_video <= outVideoTemp;
                d_lval1 <= i_lval_intern;
                o_lval <= d_lval1;
                d_fval1 <= i_fval_intern;
                o_fval <= d_fval1;       
            end if; 
    end process sync_input;
    
    
     calc: process(i_clk)  
        begin 
            if rising_edge(i_clk) then
            
                if i_fval_intern = '1' and i_lval_intern = '1' then
                    DIG_OFFSET(i_video_intern, i_dig_offset, zwSP);
                    outVideoTemp <= DIF_GAIN(zwSP, i_dig_gain, 4, 8);
                end if;
            
               
            end if; 
    end process calc;

    







end Behavioral;
