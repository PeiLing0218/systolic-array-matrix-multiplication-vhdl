library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Systolic_Array is
    port(
        clk, rst      : in  std_logic;
        A1, A2, B1, B2 : in  std_logic_vector(15 downto 0);
        C11, C12, C21, C22 : out std_logic_vector(31 downto 0)
    );
end Systolic_Array;

architecture RTL of Systolic_Array is
    component Systolic_Cell
        port(
            clk, rst      : in  std_logic;
            a_in, b_in    : in  std_logic_vector(15 downto 0);
            a_out, b_out  : out std_logic_vector(15 downto 0);
            result        : out std_logic_vector(31 downto 0)
        );
    end component;

    signal A1_next, A2_next, B1_next, B2_next : std_logic_vector(15 downto 0);

begin
    -- Instantiate systolic cells
    cell_W: Systolic_Cell port map(clk => clk, rst => rst, a_in => A1, b_in => B1, a_out => A1_next, b_out => B1_next, result => C11);
    cell_X: Systolic_Cell port map(clk => clk, rst => rst, a_in => A1_next, b_in => B2, a_out => open, b_out => B2_next, result => C12);
    cell_Y: Systolic_Cell port map(clk => clk, rst => rst, a_in => A2, b_in => B1_next, a_out => A2_next, b_out => open, result => C21);
    cell_Z: Systolic_Cell port map(clk => clk, rst => rst, a_in => A2_next, b_in => B2_next, a_out => open, b_out => open, result => C22);

end RTL;
