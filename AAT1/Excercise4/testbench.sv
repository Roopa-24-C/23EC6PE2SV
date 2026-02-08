// File        :tb_8-byte_packet.sv
// Author      :Roopashri.C /1BM23EC218
// Created     :08-02-2026
// Module      :tb_etpacket_class
// Project     :SystemVerilog & Verification(23EC6PE2SV)
// Faculty     :Prof.Ajaykumar Devarapalli
// Description :The testbench randomizes packets and prints them while sampling coverage for packet lengths.Waveforms and coverage confirm payload size changes correctly across packets.




module tb;

  EthPacket pkt;

  // signal for waveform viewing
  int len_sig;

  
  covergroup pkt_cov;

    len_cp : coverpoint len_sig {
      bins lengths[] = {[4:8]};
    }

  endgroup

  pkt_cov cov = new();
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    pkt = new();

    repeat (20) begin
      assert(pkt.randomize());

      len_sig = pkt.len;   // waveform signal
      cov.sample();

      $display("Packet Length = %0d", pkt.len);
      $display("Payload Size = %0d", pkt.payload.size());
      $display("Payload = %p\n", pkt.payload);

      #10;
    end

    $display("Coverage = %0.2f %%", cov.get_coverage());
    #10 $finish;
  end

endmodule
