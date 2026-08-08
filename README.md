# Systolic Array Matrix Multiplier (VHDL)

A 2×2 systolic array for matrix multiplication, built from a reusable
processing-element (PE) cell. Verified in Vivado at both the cell and
array level against hand-calculated reference values.

## Repository Structure

```text
systolic-array-matrix-mult/
├── README.md
├── src/                        Synthesizable VHDL design sources
│   ├── pe_cell.vhd             Standalone processing element (MAC unit)
│   ├── systolic_cell.vhd       PE variant wired for array interconnect
│   └── systolic_array.vhd      Top-level 2×2 array (top module)
├── sim/                        Testbenches
│   ├── pe_cell_tb.vhd
│   └── systolic_array_tb.vhd
└── docs/                       Simulation output
    ├── pe_cell_output.png
    └── systolic_array_output.png
```

## Tools

VHDL · AMD Xilinx Vivado (or any standard simulator, e.g. ModelSim, GHDL)

## Getting Started (Vivado)

1. Create a new project, select your target FPGA part.
2. **Design Sources:** add all files from `src/`; set `systolic_array.vhd` as the Top Module.
3. **Simulation Sources:** add all files from `sim/`. Keep testbenches out of Design Sources.
4. Set `pe_cell_tb.vhd` or `systolic_array_tb.vhd` as the simulation top, then **Run → Run Behavioral Simulation**.

## Using This Code With Your Own Values

To test different matrices or operands, edit the input and expected-output
values directly in the testbench files (`sim/`) — no changes needed in `src/`.

## Simulation Results

**PE cell** — `pe_cell_tb.vhd` applies known operand pairs and confirms correct multiply-accumulate output before integration.

**Systolic array** — `systolic_array_tb.vhd` applies two input matrices and checks all four output products (C11–C22) against hand-calculated reference values, cycle by cycle. Result: 100% match, correct pipelined timing confirmed.

## What This Demonstrates

- Bottom-up RTL design: unit-level verification before system integration
- Self-checking testbenches at both cell and array level
- Verification against a golden/reference model
