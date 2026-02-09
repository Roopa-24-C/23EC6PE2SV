// File        :ATM_TOP.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :09-02-2026
// Module      :Top
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :This top module connects the ATM design and testbench through the interface and generates the clock signal.It acts as the main simulation wrapper to verify ATM functionality.
module Top;

atm_if vif();

initial begin
    vif.clk = 0;
    forever #5 vif.clk = ~vif.clk;
end

ATM dut(
    .clk(vif.clk),
    .reset(vif.reset),
    .card_inserted(vif.card_inserted),
    .pin_correct(vif.pin_correct),
    .balance_ok(vif.balance_ok),
    .dispense_cash(vif.dispense_cash)
);

ATM_tb tb(vif);

endmodule
