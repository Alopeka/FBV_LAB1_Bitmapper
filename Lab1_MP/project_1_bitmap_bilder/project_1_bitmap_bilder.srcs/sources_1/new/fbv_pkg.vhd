----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2022 11:59:57
-- Design Name: 
-- Module Name: fbv_pkg - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package fbv_pkg is


end fbv_pkg;

package body fbv_pkg is




--hierrein prozedur und function
procedure DIG_OFFSET(signal iData, Offset: in std_logic_vector; --hier nochmal Ackermann fragen: Warum ist hier keine Vectorlänge angegeben
                     signal Result: out std_logic_vector) is
                     
variable calcRes: unsigned := "0";  --Result_of_Calculation --Frage Ack Wiso geht 0 statt "0" nicht? Geht das nur bei Signal?
        
 
                     
begin

 calcRes := unsigned(iData) + unsigned(Offset); --Varibalnen := statt <=

 if (Offset(Offset'left) = '0' and calcRes'length = iData'length+1 and calcRes(calcRes'left) = '1') then -- Todo +1bit ausgeben
 Result(iData'left+1 downto 0)<= std_logic_vector(calcRes);
 
 end if;

 
 if (Offset(Offset'left) = '0' and (calcRes'length /= iData'length+1 or calcRes(calcRes'left) = '0')) then -- Todo iData lengt bit ausgeben
 
 Result(iData'left downto 0)<= std_logic_vector(calcRes);
 
 end if;

 if (Offset(Offset'left) = '1' and calcRes'length = iData'length+1 and calcRes(calcRes'left) = '1') then -- i Data length bit ausgeben
 
 Result(iData'left downto 0)<= std_logic_vector(calcRes);

 end if;

 
 if (Offset(Offset'left) = '1' and (calcRes'length /= iData'length+1 or calcRes(calcRes'left) = '0')) then -- 0bit ausgeben
 
 Result(iData'range)<= (others => '0');


 
 end if;
 
 


end DIG_OFFSET;




end fbv_pkg;


