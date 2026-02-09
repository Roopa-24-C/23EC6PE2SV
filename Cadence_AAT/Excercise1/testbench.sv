// File        :tb_ALU.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :09-02-2026
// Module      :tb_ALU
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :This testbench applies different input combinations to verify all ALU operations.It also generates waveform data and runs random tests to check ALU functionality thoroughly.

module ALU_tb(alu_if vif);

initial begin
    $shm_open("waves.shm");
    $shm_probe("AS", Top.dut);

    // ADD
    vif.a = 10; vif.b = 5; vif.opcode = 0; #10;

    // SUB
    vif.a = 10; vif.b = 3; vif.opcode = 1; #10;

    // MUL
    vif.a = 4; vif.b = 5; vif.opcode = 2; #10;

    // XOR
    vif.a = 8; vif.b = 3; vif.opcode = 3; #10;

    // repeat operations
    repeat(20) begin
        vif.a = $random;
        vif.b = $random;
        vif.opcode = $random % 4;
        #10;
    end

    $finish;
end

endmodule
