// File        :FSM.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :01-02-206
// Module      :fsm
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :This module implements a 101 sequence detector FSM with state transitions controlled by clock and reset.
module fsm(input clk, rst, in, output logic out);

  typedef enum logic [1:0] {s0, s1, s2} state_t;
  state_t state, next;

  // State register
  always_ff @(posedge clk)
    state <= rst ? s0 : next;

  // Next state logic
  always_comb begin
    case(state)
      s0: next = in ? s1 : s0;
      s1: next = in ? s2 : s0;
      s2: next = in ? s2 : s0;
      default: next = s0;
    endcase
  end

  // Example output logic
  assign out = (state == s2);

endmodule
