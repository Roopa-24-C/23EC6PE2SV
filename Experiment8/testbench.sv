// File        :tb_FIFO.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :01-02-2026
// Module      :tb
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :The testbench uses an interface and coverage to verify FIFO behavior, including writes when full.
interface fifo_if(input clk);
  logic wr, rd, full, empty;
  logic [7:0] din;
endinterface 

module tb;

  bit clk = 0;
  always #5 clk = ~clk;

  fifo_if vif(clk);

  fifo dut (
    .clk(clk),
    .wr(vif.wr),
    .rd(vif.rd),
    .din(vif.din),
    .full(vif.full),
    .empty(vif.empty)
  );

  // Coverage
  covergroup cg_fifo @(posedge clk);
    cross_wr_full: cross vif.wr, vif.full;
  endgroup

  cg_fifo cg = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    // Fill FIFO
    vif.wr = 1;
    vif.rd = 0;
    repeat (20) begin
      vif.din = $urandom;
      @(posedge clk);
      cg.sample();
    end

    // Read to clear FIFO
    vif.wr = 0;
    vif.rd = 1;
    repeat (10) begin
      @(posedge clk);
      cg.sample();
    end

    // Idle case
    vif.rd = 0;
    @(posedge clk);
    cg.sample();

    $display("coverage : %0.2f %%", cg.get_inst_coverage());
    $finish;
  end

endmodule
