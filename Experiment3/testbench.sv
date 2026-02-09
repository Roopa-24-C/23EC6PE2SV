// File        :tb_priority_enc.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :29-01-2026
// Module      :pri_en_tb
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :This testbench verifies a 4-bit priority encoder by applying random input values.Functional coverage is used to ensure all priority cases and other input combinations are exercised.
module pri_en_tb;

  logic [3:0] in;
  logic [1:0] out;
  logic valid;

  pri_en dut(.*);

  // Coverage
  covergroup cp_enc;

    cp_in: coverpoint in {
      bins b0 = {4'b0001};
      bins b1 = {4'b0010};
      bins b2 = {4'b0100};
      bins b3 = {4'b1000};
      bins others = default;
    }

  endgroup

  cp_enc cg = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    // Force all important cases first
    in = 4'b0001; #5 cg.sample();
    in = 4'b0010; #5 cg.sample();
    in = 4'b0100; #5 cg.sample();
    in = 4'b1000; #5 cg.sample();

    // Random tests
    repeat (50) begin
      in = $urandom_range(0,15);
      #5;
      cg.sample();
    end

    $display("Full coverage = %0.2f %%", cg.get_inst_coverage());
    $finish;
  end

endmodule
