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
