// File        :ALU_TOP_MODULE.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :09-02-2026
// Module      :Top
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :This top module connects the ALU design with the testbench using the interface.It acts as the main wrapper to run simulation and verify the ALU.

module Top;

alu_if vif();

ALU dut(
    .a(vif.a),
    .b(vif.b),
    .opcode(vif.opcode),
    .result(vif.result)
);

ALU_tb tb(vif);

endmodule
