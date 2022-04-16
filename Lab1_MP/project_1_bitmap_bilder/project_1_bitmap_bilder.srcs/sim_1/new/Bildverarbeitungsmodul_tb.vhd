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
use std.textio.all;

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
    i_dig_gain <= "00011000";
    i_dig_offset <= "00000100";
    i_clk <= '0';
    wait for 5ns;
    i_clk <= '1';
    wait for 5ns;
    end process;
    
rd_proc: process
    file inFile: text open READ_MODE is "C:\Users\Tarag\OneDrive\Dokumente\Studium\SS22\FbV\lena_sw.txt";
    variable rdLine: line;
    variable rows, columns, depth: positive;
    variable i: positive;
    variable val: integer;
    
begin
    readline(inFile, rdLine);
    read(rdLine, rows);
    read(rdLine, columns);
    read(rdLine, depth);
    while not(endfile(inFile)) loop
        readline(inFile, rdLine);
        i_lval <= '1';
        i_fval <= '1';
        for i in 0 to columns-1 loop
            read(rdLine, val);
            i_video <= std_logic_vector(to_unsigned(val,depth));
            wait until falling_edge(i_clk);
        end loop; 
        i_lval <= '0';
        wait for 200ns;
    end loop;
    i_fval <= '0';
    file_close(inFile);
    wait;

end process rd_proc;

wr_proc: process
    file outfile: text open WRITE_MODE is "C:\Users\Tarag\OneDrive\Dokumente\Studium\SS22\FbV\lenaOut.txt";
    variable buf: LINE; 
    variable running: boolean := TRUE;
    variable lval_old: std_logic := '0';
begin
    write(buf, string'("256 256 8"));
    writeline(outfile, buf);
    while(running) loop
        wait until falling_edge(i_clk);
        if(o_lval = '1' and o_fval = '1') then
              write(buf, integer'image(to_integer(unsigned(o_video))));
              write(buf, ' ');
        end if;

        if(o_lval < lval_old) then --falling edge funktioniert hier nicht weil oben wait until falling edge steht und deshalb die falling edge hier in der vergangenheit liget?
            writeline(outfile, buf);
        end if;
        
        lval_old := o_lval;
    end loop;
    wait;
end process;

end Behavioral;
