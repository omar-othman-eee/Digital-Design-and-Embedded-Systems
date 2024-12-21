library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_ROM is
    port (
        CLK      : in  STD_LOGIC; -- Clock signal 
        RE       : in  STD_LOGIC; -- Read enable 
        CE       : in  STD_LOGIC; -- Chip enable  
        ADDR     : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit ROM address 
        A        : in  STD_LOGIC_VECTOR(7 downto 0); -- Operand A
        Opselect : in  STD_LOGIC_VECTOR(1 downto 0); -- Operation selector; "00" = Addition, "01" = Subtraction, "10" = Multiplication, "11" = Division,   
        RESULT   : out STD_LOGIC_VECTOR(7 downto 0); -- returned sum, difference, product or quotient  
        Cin : out STD_LOGIC; -- Carry in 
        Cout: out STD_LOGIC -- Carry out 
    );
end ALU_ROM;

architecture ALUarch of ALU_ROM is
    type ROM_Array is array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
    constant Content : ROM_Array := (
        0 => "00000100",
        1 => "00001000",
        2 => "00010100",
        3 => "00100011",
        4 => "01000010",
        5 => "01100100",
        6 => "10000011",
        7 => "10000100"
    );
    signal ROMData: STD_LOGIC_VECTOR(7 downto 0); --defining a new signal
begin
    process(CLK, RE, CE)
    begin
        if (CLK'event and CLK = '1') then
            if (CE = '1') then
                if (RE = '1') then
                    ROMData <= Content(to_integer(unsigned(ADDR)));
                else
                    ROMData <= (others => 'Z');
                end if;
            else
                ROMData <= (others => 'Z');
            end if;
        end if;
    end process;

    process(A, ROMData, Opselect)
        variable temp_result : unsigned(7 downto 0); -- For intermediate calculations
        variable multiplicationoverflow : unsigned (15 downto 0);
    begin
        Cin <= '0'; -- Initial carry in 
        Cout <= '0'; -- Initial carry out
        case Opselect is
            when "00" => -- Addition
                temp_result := unsigned(A) + unsigned(ROMData);
                RESULT <= std_logic_vector(temp_result(7 downto 0));
                Cout <= temp_result(7); -- Carry out from the addition

            when "01" => -- Subtraction
                temp_result := unsigned(A) - unsigned(ROMData);
                RESULT <= std_logic_vector(temp_result(7 downto 0));
                Cout <= temp_result(7); -- Borrow flag

            when "10" => -- Multiplication
                multiplicationoverflow := unsigned(A) * unsigned(ROMData);
                RESULT <= std_logic_vector(multiplicationoverflow (7 downto 0));
                Cout <= multiplicationoverflow(8); -- Overflow in multiplication

            when "11" => -- Division
                if ROMData = "00000000" then -- Dividing by zero
                    RESULT <= (others => '0'); -- Undefined, return 0
                else
                    temp_result := unsigned(A) / unsigned(ROMData);
                    RESULT <= std_logic_vector(temp_result(7 downto 0));
                end if;

            when others =>
                RESULT <= (others => '0'); -- Default case
        end case;
    end process;
end ALUarch;
