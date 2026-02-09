// File        :ATM_Controller.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :09-02-2026
// Module      :ATM
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :This ATM module uses a finite state machine to control cash withdrawal steps.It checks card insertion, PIN validity, and balance before dispensing cash.

module ATM(
    input logic clk,
    input logic reset,
    input logic card_inserted,
    input logic pin_correct,
    input logic balance_ok,
    output logic dispense_cash
);

typedef enum logic [1:0] {
    IDLE,
    CHECK_PIN,
    CHECK_BAL,
    DISPENSE
} state_t;

state_t state, next_state;

always_ff @(posedge clk or posedge reset) begin
    if(reset)
        state <= IDLE;
    else
        state <= next_state;
end

always_comb begin
    dispense_cash = 0;

    case(state)
        IDLE:
            next_state = card_inserted ? CHECK_PIN : IDLE;

        CHECK_PIN:
            next_state = pin_correct ? CHECK_BAL : IDLE;

        CHECK_BAL:
            next_state = balance_ok ? DISPENSE : IDLE;

        DISPENSE: begin
            dispense_cash = 1;
            next_state = IDLE;
        end
    endcase
end

endmodule
