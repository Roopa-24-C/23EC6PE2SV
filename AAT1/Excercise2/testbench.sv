// File        :tb_digital_clock.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :08-02-2026
// Module      :tb_sec_min_counter
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :The testbench uses transition bins to verify the seconds transition from 59 to 0.Coverage ensures minutes increment correctly when seconds wrap around.
module tb;

  logic clk, rst;
  logic [5:0] sec, min;

  sec_min_counter dut(clk, rst, sec, min);

  always #5 clk = ~clk;

  // Coverage
  covergroup cg @(posedge clk);

    // Seconds rollover
    sec_cp : coverpoint sec {
      bins wrap = (59 => 0);
    }

    // Cover all minute values + rollover
    min_cp : coverpoint min {
      bins all_vals[] = {[0:59]};
      bins wrap = (59 => 0);
    }

  endgroup

  cg cov = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    clk = 0;
    rst = 1;
    #10 rst = 0;

    // Run long enough for minute rollover
    repeat (4000) begin
      @(posedge clk);
      cov.sample();
      $display("Time=%0t sec=%0d min=%0d",
                $time, sec, min);
    end

    $display("Coverage = %0.2f %%", cov.get_coverage());
    $finish;
  end

endmodule
