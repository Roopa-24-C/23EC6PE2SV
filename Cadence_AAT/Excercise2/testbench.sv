// File        :ATM_tb.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :09-02-2026
// Module      :ATM_tb
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :This testbench simulates different ATM transaction scenarios to verify correct state transitions.It checks normal operation, wrong PIN, insufficient balance, reset behavior, and repeated transactions.

module ATM_tb(atm_if vif);

initial begin
    $shm_open("waves.shm");
    $shm_probe("AS", Top.dut);

    //---------------- RESET -------------//
    vif.reset = 1;
    vif.card_inserted = 0;
    vif.pin_correct = 0;
    vif.balance_ok = 0;
    #20;
    vif.reset = 0;

    //---------------- Case 1: correct flow --------//
    vif.card_inserted = 1;
    #20;

    vif.pin_correct = 1;
    #20;

    vif.balance_ok = 1;
    #20;

    vif.card_inserted = 0;
    vif.pin_correct = 0;
    vif.balance_ok = 0;
    #40;

    //---------------- Case 2: wrong PIN -----------//
    vif.card_inserted = 1;
    #20;

    vif.pin_correct = 0;
    #40;

    vif.card_inserted = 0;
    #20;

    //---------------- Case 3: insufficient balance //
    vif.card_inserted = 1;
    #20;

    vif.pin_correct = 1;
    #20;

    vif.balance_ok = 0;
    #40;

    vif.card_inserted = 0;
    #20;

    //---------------- Case 4: reset mid-transaction //
    vif.card_inserted = 1;
    #20;

    vif.reset = 1;
    #20;
    vif.reset = 0;

    //---------------- repeat transitions --------//
    repeat(5) begin
        vif.card_inserted = 1;
        #10;
        vif.pin_correct = $random;
        vif.balance_ok = $random;
        #20;

        vif.card_inserted = 0;
        vif.pin_correct = 0;
        vif.balance_ok = 0;
        #20;
    end

    $display("ATM TEST COMPLETED");
    #20 $finish;
end

endmodule
