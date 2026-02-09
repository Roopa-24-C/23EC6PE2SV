// File        :ALU.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :09-02-2026
// Module      :ALU
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :This ALU module performs arithmetic and logical operations on two 32-bit inputs based on a 2-bit opcode.
//It outputs addition, subtraction, multiplication, or XOR results depending on the selected operation.

module ALU(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [1:0] opcode,
    output logic [31:0] result
);

always_comb begin
    case(opcode)
        2'b00: result = a + b;
        2'b01: result = a - b;
        2'b10: result = a * b;
        2'b11: result = a ^ b;
        default: result = 0;
    endcase
end

endmodule
