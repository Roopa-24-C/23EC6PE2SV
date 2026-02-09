// File        :ALU_INTERFACE.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :09-02-2026
// Module      :alu_if
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :This interface groups ALU input and output signals into a single communication bundle.It simplifies connection between the ALU design and the testbench.
interface alu_if;
    logic [31:0] a, b;
    logic [1:0] opcode;
    logic [31:0] result;
endinterface
