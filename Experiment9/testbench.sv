/ File        :tb_FSM.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :01-02-2026
// Module      :tb
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :The testbench monitors FSM states using coverage to ensure all states are exercised.

module tb;

  logic clk = 0, rst, in, out;

  always #5 clk = ~clk;

  fsm dut(.*);

  // Coverage
  covergroup cg_fsm @(posedge clk);
    cp_state : coverpoint dut.state;
  endgroup

  cg_fsm cg = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    // Reset
    rst = 1;
    @(posedge clk);
    rst = 0;

    // Directed transitions
    in = 1; @(posedge clk); cg.sample(); // s0→s1
    in = 1; @(posedge clk); cg.sample(); // s1→s2
    in = 0; @(posedge clk); cg.sample(); // s2→s0

    // Random testing
    repeat (20) begin
      in = $urandom % 2;
      @(posedge clk);
      cg.sample();
    end

    $display("coverage = %0.2f%%", cg.get_inst_coverage());
    $finish;
  end

endmodule
