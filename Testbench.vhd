library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench is
end testbench;

architecture arch_tb of testbench is
    -- Component Declaration
    component ALU_ROM is
        port (
            CLK      : in  STD_LOGIC; 
            RE       : in  STD_LOGIC; 
            CE       : in  STD_LOGIC;
            ADDR     : in  STD_LOGIC_VECTOR(2 downto 0);
            A        : in  STD_LOGIC_VECTOR(7 downto 0);
            Opselect : in  STD_LOGIC_VECTOR(1 downto 0);
            RESULT   : out STD_LOGIC_VECTOR(7 downto 0);
            Cin      : out STD_LOGIC;
            Cout     : out STD_LOGIC
        );
    end component;

    -- Declaring signals
    signal CLK      : STD_LOGIC := '0';
    signal RE       : STD_LOGIC := '0';
    signal CE       : STD_LOGIC := '0';
    signal ADDR     : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal A        : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Opselect : STD_LOGIC_VECTOR(1 downto 0) := "00"; -- default signal 
    signal RESULT   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Cin      : STD_LOGIC := '0';
    signal Cout     : STD_LOGIC := '0';

begin
    -- Instantiating the ALU
    UUT: ALU_ROM -- Unit under test
        port map(
            CLK      => CLK,
            RE       => RE,
            CE       => CE,
            ADDR     => ADDR,
            A        => A,
            Opselect => Opselect,
            RESULT   => RESULT,
            Cin      => Cin,
            Cout     => Cout
        );

    -- Clock Generation
    clk_process: process
    begin
        while true loop
            CLK <= '1';
            wait for 20 ns;
            CLK <= '0';
            wait for 20 ns;
        end loop;
    end process;

    -- Stimulus Process
    stimulus_process: process
    begin
        -- Initialization and Reset
        RE <= '0'; CE <= '0';
        A <= (others => '0');
        Opselect <= "00";
        wait for 40 ns;

        -- Enable ROM and ALU
        RE <= '1'; CE <= '1';
        wait for 20 ns;

        -- Test Addition (Opselect = "00")
        Opselect <= "00";  -- Select addition
        A <= "00001010";   -- A = 10
        ADDR <= "000";     -- ROM address 0 (4)
        wait for 40 ns;

        -- Test Subtraction (Opselect = "01")
        Opselect <= "01";
        A <= "00001100";  -- A = 12
        ADDR <= "001";    -- ROM address 1 (8)
        wait for 40 ns;

        -- Test Multiplication (Opselect = "10")
        Opselect <= "10";
        A <= "00000011";  -- A = 3
        ADDR <= "010";    -- ROM address 2 (20)
        wait for 40 ns;

        -- Test Division (Opselect = "11")
        Opselect <= "11";
        A <= "00010000";  -- A = 16
        ADDR <= "011";    -- ROM address 3 (35)
        wait for 40 ns;

        -- Division by Zero
        Opselect <= "11";
        A <= "00010000";
        ADDR <= "100";  -- ROM address 4 (Division by Zero)
        wait for 40 ns;

        -- Finish simulation
        wait;
    end process;
end arch_tb;
