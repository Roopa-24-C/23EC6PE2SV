// File        :tb_associate_arrays.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :02-02-2026
// Module      :tb_memory_model
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :Associative array memory stores data only for used addresses, efficiently modeling large memories.
module tb;

  logic clk = 0;
  logic wr_en, rd_en;
  int addr;
  int wdata;
  int rdata;

  always #5 clk = ~clk;

  memory_model dut (
    .clk(clk),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata)
  );

  // Reference memory
  int ref_mem[int];

  // Coverage
  covergroup mem_cov @(posedge clk);
    wr_cp : coverpoint wr_en;
    rd_cp : coverpoint rd_en;
  endgroup

  mem_cov cov = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    wr_en = 0;
    rd_en = 0;

    //---------------- WRITE PHASE ----------------//
    repeat (10) begin
      @(posedge clk);
      wr_en = 1;
      addr  = $urandom_range(0,100);
      wdata = $urandom_range(0,255);

      ref_mem[addr] = wdata;

      cov.sample();

      $display("WRITE addr=%0d data=%0d", addr, wdata);
    end

    @(posedge clk);
    wr_en = 0;

    //---------------- READ PHASE ----------------//
    repeat (10) begin
      @(posedge clk);
      rd_en = 1;
      addr  = $urandom_range(0,100);

      cov.sample();

      @(posedge clk);

      if (ref_mem.exists(addr) &&
          rdata == ref_mem[addr])
        $display("PASS addr=%0d data=%0d",
                  addr, rdata);
      else if (!ref_mem.exists(addr) &&
               rdata == 0)
        $display("PASS addr=%0d empty", addr);
      else
        $display("FAIL addr=%0d expected=%0d got=%0d",
                  addr,
                  ref_mem.exists(addr) ? ref_mem[addr] : 0,
                  rdata);
    end

    rd_en = 0;

    $display("Coverage = %0.2f %%", cov.get_coverage());

    #10 $finish;
  end

endmodule

