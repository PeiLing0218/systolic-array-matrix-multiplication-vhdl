library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Systolic_Cell is
    port(clk, rst : in  std_logic;
        a_in, b_in : in  std_logic_vector(15 downto 0);
        a_out, b_out : out std_logic_vector(15 downto 0);
        result : out std_logic_vector(31 downto 0));
end Systolic_Cell;

architecture Behavioral of Systolic_Cell is
    signal a_reg, b_reg : std_logic_vector(15 downto 0) := (others => '0');
    signal acc          : std_logic_vector(31 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- Reset all registers
                a_reg <= (others => '0');
                b_reg <= (others => '0');
                acc <= (others => '0');
            else
                -- Latch input 
                a_reg <= a_in;
                b_reg <= b_in;
                -- Multiply and accumulate 
                acc <= std_logic_vector(
                           resize(signed(acc) + signed(a_reg) * signed(b_reg),32));
            end if;
        end if;
    end process;
    -- Connect latched values to outputs
    a_out <= a_reg;
    b_out <= b_reg;
    result <= acc;
end Behavioral;
