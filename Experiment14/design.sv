// File        :OOP_Polymerism.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :02-02-2026
// Module      :OOP
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :Demonstrates inheritance where a child class overrides the packet print behavior.
class Packet;
  rand bit [7:0] data;

  // Virtual method
  virtual function void print();
    $display("Normal Packet: %h", data);
  endfunction
endclass


class BadPacket extends Packet;

  // Method override
  virtual function void print();
    $display("ERROR Packet: %h", data);
  endfunction

endclass
