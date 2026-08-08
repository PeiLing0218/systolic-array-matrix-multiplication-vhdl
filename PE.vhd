library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PE is
    port (
        clk, rst  : in  std_logic;
        a_in, b_in: in  std_logic_vector(12 downto 0);
        a_out, b_out: out std_logic_vector(12 downto 0);
        acc_out   : out std_logic_vector(31 downto 0)
    );
end entity PE;

architecture simple of PE is
    signal a_reg, b_reg : signed(12 downto 0) := (others => '0');
    signal acc_reg      : signed(31 downto 0) := (others => '0');
begin
    process(clk, rst)
    begin
        if rst = '1' then
            a_reg   <= (others => '0');
            b_reg   <= (others => '0');
            acc_reg <= (others => '0');
        elsif rising_edge(clk) then
            a_reg   <= signed(a_in);
            b_reg   <= signed(b_in);
            acc_reg <= acc_reg + resize(a_reg * b_reg, 32);
        end if;
    end process;

    a_out   <= std_logic_vector(a_reg);
    b_out   <= std_logic_vector(b_reg);
    acc_out <= std_logic_vector(acc_reg);
end architecture simple;


