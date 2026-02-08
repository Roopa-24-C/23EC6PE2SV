// File        :dual_port_ram.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :08-02-2026
// Module      :dual_port_ram
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :The dual-port RAM allows data to be written through Port A and read independently through Port B.Memory updates occur on the clock edge while read data is provided for the requested address.
`timescale 1ns/1ps


module dual_port_ram #(
  parameter ADDR_WIDTH = 4,
  parameter DATA_WIDTH = 8
)(
  input logic clk,

  // Port A - Write
  input logic we_a,
  input logic [ADDR_WIDTH-1:0] addr_a,
  input logic [DATA_WIDTH-1:0] wdata_a,

  // Port B - Read
  input logic [ADDR_WIDTH-1:0] addr_b,
  output logic [DATA_WIDTH-1:0] rdata_b
);

  logic [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

  // Write
  always_ff @(posedge clk) begin
    if (we_a)
      mem[addr_a] <= wdata_a;
  end

  // Read
  assign rdata_b = mem[addr_b];

endmodule
