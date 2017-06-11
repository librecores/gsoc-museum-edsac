`timescale 1ns / 1ps

module memory_tb();

   wire [575:0] monitor;
   wire         mob;
   reg          clk = 1'b0;
   reg          mib = 1'b0;
   reg          t_in = 1'b0;
   reg          t_clr = 1'b1;
   reg          t_out = 1'b0;

   memory mem_uut
     (.monitor (monitor),
      .mob_tn  (mob),
      .clk     (clk),
      .mib     (mib),
      .tn_in   (t_in),
      .tn_clr  (t_clr),
      .tn_out  (t_out)
     );

   initial begin
      $dumpfile("memory.vcd");
      $dumpvars(1, memory_tb);

      #17 t_in = 1'b1;
      mib = 1'b1;
      #29 mib = 1'b0;
      #13 t_in = 1'b0;

      #78 t_in = 1'b1;
      mib = 1'b1;
      #12 mib = 1'b0;
      #9 mib = 1'b1;
      #10 mib = 1'b0;
      #8 t_in = 1'b0;

      #34 t_out = 1'b1;
      #44 t_out = 1'b0;

      #39 t_clr = 1'b0;
      #37 t_clr = 1'b1;

      #60 $finish;
   end

   always #5 clk = ~clk;

endmodule
