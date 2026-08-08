library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Systolic_Array is
end tb_Systolic_Array;

architecture sim of tb_Systolic_Array is
    component Systolic_Array
        port(
            clk, rst       : in  std_logic;
            A1, A2, B1, B2 : in  std_logic_vector(15 downto 0);
            C11, C12, C21, C22 : out std_logic_vector(31 downto 0)
        );
    end component;

    signal clk, rst       : std_logic := '0';
    signal A1, A2         : std_logic_vector(15 downto 0);
    signal B1, B2         : std_logic_vector(15 downto 0);
    signal C11, C12, C21, C22 : std_logic_vector(31 downto 0);
    constant clk_period   : time := 10 ns;

begin
    -- Instantiate UUT
    UUT: Systolic_Array port map(clk => clk, rst => rst, A1 => A1, A2 => A2, B1 => B1, B2 => B2,
                                C11 => C11, C12 => C12, C21 => C21, C22 => C22);

    -- Clock generation
    clk_process: process
    begin
        loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        rst <= '1';
        wait for 2 * clk_period;
        rst <= '0';

        -- Input sequences
        A1 <= std_logic_vector(to_signed(4,16)); A2 <= std_logic_vector(to_signed(0,16));
        B1 <= std_logic_vector(to_signed(6,16)); B2 <= std_logic_vector(to_signed(0,16));
        wait for clk_period;

        A1 <= std_logic_vector(to_signed(9,16)); A2 <= std_logic_vector(to_signed(8,16));
        B1 <= std_logic_vector(to_signed(4,16)); B2 <= std_logic_vector(to_signed(5,16));
        wait for clk_period;

        A1 <= std_logic_vector(to_signed(0,16)); A2 <= std_logic_vector(to_signed(5,16));
        B1 <= std_logic_vector(to_signed(0,16)); B2 <= std_logic_vector(to_signed(9,16));
        wait for clk_period;

        -- Zero padding
        A1 <= (others => '0'); A2 <= (others => '0');
        B1 <= (others => '0'); B2 <= (others => '0');
        wait for clk_period;

        wait for 50 ns;
        report "Simulation finished" severity note;
        wait;
    end process;
end sim;
