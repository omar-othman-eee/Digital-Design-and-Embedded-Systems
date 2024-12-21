-- Library declarations
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity Declaration
entity ALU is
    port (
        A        : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operand A
        B        : in  STD_LOGIC_VECTOR(7 downto 0);  -- Operand B
        OpSelect : in  STD_LOGIC_VECTOR(1 downto 0);  -- Operation selector (00=Add, 01=Sub, 10=Mult, 11=Div)
        RESULT   : out STD_LOGIC_VECTOR(15 downto 0); -- 16-bit result
        Cout     : out STD_LOGIC -- Carry/Overflow flag
    );
end entity ALU;

-- Architecture Body
architecture Behavioral of ALU is
begin
    process (A, B, OpSelect)
        variable Result_Int : signed(15 downto 0);  -- For intermediate results
    begin
        case OpSelect is
            when "00" =>  -- Addition
                Result_Int := signed(A) + signed(B);
                RESULT <= std_logic_vector(Result_Int);
                Cout <= Result_Int(8);  -- Overflow for addition

            when "01" =>  -- Subtraction
                Result_Int := signed(A) - signed(B);
                RESULT <= std_logic_vector(Result_Int);
                Cout <= Result_Int(8);  -- Borrowing subtraction

            when "10" =>  -- Multiplication
                Result_Int := signed(A) * signed(B);
                RESULT <= std_logic_vector(Result_Int);
                Cout <= '0';  -- No carry defined for multiplication

            when "11" =>  -- Division
                if B = "00000000" then  -- Check for division by zero
                    RESULT <= (others => '0');  -- Default result for division by zero
                    Cout <= '1';  -- Division by zero error flag
                else
                    Result_Int := signed(A) / signed(B);
                    RESULT <= std_logic_vector(Result_Int);
                    Cout <= '0';  -- No overflow for division
                end if;

            when others =>
                RESULT <= (others => '0');  -- Default for undefined operations
                Cout <= '0';
        end case;
    end process;
end architecture Behavioral;
