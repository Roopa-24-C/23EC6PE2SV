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
