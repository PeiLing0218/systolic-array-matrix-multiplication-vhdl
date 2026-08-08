library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_PE is
end entity;

architecture sim of tb_PE is
    -- DUT (Device Under Test) signals
    signal clk, rst : std_logic := '0';
    signal a_in, b_in, a_out, b_out : std_logic_vector(12 downto 0) := (others => '0');
    signal acc_out : std_logic_vector(31 downto 0);
    constant CLK_PERIOD : time := 10 ns;
begin
    -- Instantiate the PE Unit
    uut: entity work.PE
        port map (
            clk => clk,
            rst => rst,
            a_in => a_in,
            b_in => b_in,
            a_out => a_out,
            b_out => b_out,
            acc_out => acc_out
        );

    -- Clock process
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Apply reset
        rst <= '1';
        wait for 2 * CLK_PERIOD;
        rst <= '0';

        -- Apply test vectors (with one clock cycle per input pair)
        -- Cycle 1: a=4, b=6 → no output yet (input registered)
        a_in <= std_logic_vector(to_signed(4, 13));
        b_in <= std_logic_vector(to_signed(6, 13));
        wait for CLK_PERIOD;

        -- Cycle 2: a=9, b=4: acc += 4×6 = 24
        a_in <= std_logic_vector(to_signed(9, 13));
        b_in <= std_logic_vector(to_signed(4, 13));
        wait for CLK_PERIOD;

        -- Cycle 3: a=0, b=8: acc += 9×4 = 36: acc = 60
        a_in <= std_logic_vector(to_signed(0, 13));
        b_in <= std_logic_vector(to_signed(8, 13));
        wait for CLK_PERIOD;

        -- Cycle 4: hold
        a_in <= (others => '0');
        b_in <= (others => '0');
        wait for CLK_PERIOD * 2;

        wait; -- end simulation
    end process;
end architecture sim;
