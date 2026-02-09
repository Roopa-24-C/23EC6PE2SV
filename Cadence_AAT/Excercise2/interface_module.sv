// File        :ATM_Interface.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :09-02-2026
// Module      :atm_if
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :This interface groups all ATM control and status signals into one connection bundle.It simplifies communication between the ATM module and its testbench.

interface atm_if;
    logic clk;
    logic reset;
    logic card_inserted;
    logic pin_correct;
    logic balance_ok;
    logic dispense_cash;
endinterface
