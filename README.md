# Systolic Array Matrix Multiplier (VHDL)

Two related VHDL designs exploring multiply-accumulate (MAC) hardware,
run and verified as independent Vivado projects:

1. **PE** — a standalone processing element (13-bit MAC unit), verified
   in isolation.
2. **Systolic_Array** — a 2×2 systolic array built from a wider (16-bit)
   `Systolic_Cell` variant, verified as a complete pipelined array.

## Repository Structure

```text
systolic-array-matrix-mult/
├── README.md
├── PE/
│   ├── PE.vhd                 Standalone processing element (MAC unit)
│   └── tb_PE.vhd              Testbench
├── Systolic_Array/
│   ├── Systolic_Cell.vhd      PE variant wired for array interconnect
│   ├── Systolic_Array.vhd     Top-level 2×2 array (top module)
│   └── tb_Systolic_Array.vhd  Testbench
└── docs/
    ├── pe_output.png
    └── systolic_array_output.png
```

## Tools

VHDL · AMD Xilinx Vivado (or any standard simulator such as ModelSim, GHDL)

## Running Each Project (Vivado)

Each folder is a self-contained project — create a separate Vivado project for each:

**PE**
1. Add `PE.vhd` as Design Source (Top Module), `tb_PE.vhd` as Simulation Source.
2. Run Behavioral Simulation.

**Systolic_Array**
1. Add `Systolic_Cell.vhd` and `Systolic_Array.vhd` as Design Sources; set `Systolic_Array.vhd` as Top Module.
2. Add `tb_Systolic_Array.vhd` as Simulation Source.
3. Run Behavioral Simulation.

## Using This Code With Your Own Values

To test different operands, edit the input and expected-output values
directly in the testbench files — no changes needed in the design files.

## Simulation Results

**PE** — `tb_PE.vhd` applies known operand pairs and confirms correct multiply-accumulate output.
![PE simulation output](docs/pe_output.png)

**Systolic array** — `tb_Systolic_Array.vhd` applies two 2×2 input
matrices and checks all four output products (C11–C22) against
hand-calculated reference values, cycle by cycle. Result: 100% match,
correct pipelined timing confirmed.
![Systolic array simulation output](docs/systolic_array_output.png)

## What This Demonstrates

- RTL design and verification at both the unit and system level
- Self-checking testbenches
- Verification against a golden/reference model
