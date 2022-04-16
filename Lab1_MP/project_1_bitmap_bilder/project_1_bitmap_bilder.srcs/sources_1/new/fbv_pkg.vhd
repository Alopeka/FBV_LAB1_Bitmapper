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
function DIF_GAIN (iData: std_logic_vector; Factor: std_logic_vector; Decimals: positive; res_width: positive) return  std_logic_vector;
procedure DIG_OFFSET(signal iData, Offset: in std_logic_vector; signal Result: out std_logic_vector);--so lange wie zwSP

end fbv_pkg;

package body fbv_pkg is




--hierrein prozedur und function
procedure DIG_OFFSET(signal iData, Offset: in std_logic_vector; signal Result: out std_logic_vector) is--hier nochmal Ackermann fragen: Warum ist hier keine Vectorlänge angegeben
                     
variable calcRes: unsigned(iData'length downto 0);  --Result_of_Calculation --Frage Ack Wiso geht 0 statt "0" nicht? Geht das nur bei Signal?
                       
begin

     calcRes := '0' & unsigned(iData) + unsigned(Offset); --Varibalnen := statt <=

      if (Offset(Offset'left) = '0' and calcRes(calcRes'left) = '1' and Result'length = calcRes'length) then -- Todo +1bit ausgeben
        Result<= std_logic_vector(calcRes);
     end if;

     if (Offset(Offset'left) = '0' and calcRes(calcRes'left) = '1' and Result'length /= calcRes'length) then -- Todo +1bit ausgeben
        Result<= (others => '1');
     end if;
     
     if (Offset(Offset'left) = '0' and calcRes(calcRes'left) = '0') then -- Todo iData lengt bit ausgeben
        Result<= std_logic_vector(calcRes(iData'left downto 0));
     end if;

     if (Offset(Offset'left) = '1' and calcRes(calcRes'left) = '1') then -- i Data length bit ausgeben
        Result<= std_logic_vector(calcRes(iData'left downto 0));
     end if;

    if (Offset(Offset'left) = '1' and calcRes(calcRes'left) = '0') then -- 0bit ausgeben
        Result <= (others => '0'); 
    end if;

end DIG_OFFSET;

function DIF_GAIN (iData: std_logic_vector; Factor: std_logic_vector; Decimals: positive; res_width: positive) return  std_logic_vector is
 variable multRes: unsigned(iData'length + Factor'length -1 downto 0);
 variable divRes: unsigned(iData'length + Factor'length -1 downto 0);

begin

 multRes := unsigned(iData) * unsigned(Factor);
 divRes := shift_right(multRes, Decimals);
 if(divRes(divRes'left downto res_width) = 0) then
    return std_logic_vector(divRes(res_width-1 downto 0)); 
 else
    return (others => '1');
 end if;
 
end DIF_GAIN;



end fbv_pkg;


