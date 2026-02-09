// File        :tb_dual_port_ram.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :08-02-2026
// Module      :tb_dual_port_ram
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :The testbench writes random data to random addresses and stores it in an associative array reference model.Read data is compared with the reference model and each transaction prints PASS or FAIL.

`timescale 1ns/1ps

module tb;

  parameter ADDR_WIDTH = 4;
  parameter DATA_WIDTH = 8;

  logic clk;
  logic we_a;
  logic [ADDR_WIDTH-1:0] addr_a, addr_b;
  logic [DATA_WIDTH-1:0] wdata_a;
  logic [DATA_WIDTH-1:0] rdata_b;

  dual_port_ram #(ADDR_WIDTH, DATA_WIDTH)
      dut(clk, we_a, addr_a, wdata_a, addr_b, rdata_b);

  always #5 clk = ~clk;

  bit [DATA_WIDTH-1:0] ref_mem[int];

  // Coverage
  covergroup ram_cov @(posedge clk);

    // All addresses must be written
    addr_cp : coverpoint addr_a {
      bins addr_bins[] = {[0:15]};
    }

    // Cover low/mid/high data values
    data_cp : coverpoint wdata_a {
      bins low  = {[0:85]};
      bins mid  = {[86:170]};
      bins high = {[171:255]};
    }

    // Write enable coverage
    we_cp : coverpoint we_a {
      bins write = {1};
      bins idle  = {0};
    }

  endgroup

  ram_cov cov = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    clk = 0;
    we_a = 0;

    repeat (200) begin
      addr_a  = $urandom_range(0,15);
      wdata_a = $urandom_range(0,255);

      @(posedge clk);
      we_a = 1;

      ref_mem[addr_a] = wdata_a;

      cov.sample();

      @(posedge clk);
      we_a = 0;

      addr_b = addr_a;
      @(posedge clk);

      if (rdata_b == ref_mem[addr_b])
        $display("PASS Addr=%0d Data=%0d",
                  addr_b, rdata_b);
      else
        $display("FAIL Addr=%0d Expected=%0d Got=%0d",
                  addr_b, ref_mem[addr_b], rdata_b);
    end

    $display("Coverage = %0.2f %%", cov.get_coverage());
    $finish;
  end

endmodule

