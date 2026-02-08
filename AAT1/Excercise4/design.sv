// File        :8-byte_packet.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :08-02-2026
// Module      :ethpacket_class
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :The EthPacket class models a packet with dynamic payload data and a configurable length.Constraints ensure the payload size matches the length, limited between 4 and 8 bytes.
`timescale 1ns/1ps

class EthPacket;

  rand int len;          // packet length
  rand byte payload[];   // dynamic payload

  // Constraint: length between 4 and 8
  constraint len_c {
    len inside {[4:8]};
  }

  // Constraint: payload size equals length
  constraint size_c {
    payload.size() == len;
  }

endclass
