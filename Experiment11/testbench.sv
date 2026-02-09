// File        :tb_Arbiter.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :02-02-2026
// Module      :tb_arbiter
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :Testbench verifies that the arbiter grants only one request at a time using assertions.
module tb;

  logic clk = 0, rst;
  logic [3:0] req;
  logic [3:0] gnt;

  always #5 clk = ~clk;

  arbiter dut (
    .clk(clk),
    .rst(rst),
    .req(req),
    .gnt(gnt)
  );

  // Assertion: only one or zero grant active
  assert property (@(posedge clk) $onehot0(gnt))
    else $error("Protocol Violation: Multiple Grants!");

  // Coverage
  covergroup cg @(posedge clk);
    cp_gnt : coverpoint gnt {
      bins none = {4'b0000};
      bins g0   = {4'b0001};
      bins g1   = {4'b0010};
      bins g2   = {4'b0100};
      bins g3   = {4'b1000};
    }
  endgroup

  cg cov = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    rst = 1;
    req = 0;
    @(posedge clk);
    rst = 0;

    // Force all grant cases
    req = 4'b0001; @(posedge clk); cov.sample();
    req = 4'b0010; @(posedge clk); cov.sample();
    req = 4'b0100; @(posedge clk); cov.sample();
    req = 4'b1000; @(posedge clk); cov.sample();
    req = 4'b0000; @(posedge clk); cov.sample();

    // Random tests
    repeat (20) begin
      req = $urandom_range(0,15);
      @(posedge clk);
      cov.sample();
    end

    $display("Coverage = %0.2f %%", cov.get_coverage());
    $finish;
  end

endmodule

 
