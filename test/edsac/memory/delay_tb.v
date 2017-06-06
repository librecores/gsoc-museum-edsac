`timescale 1ns / 1ps

module delay_tb();

   wire out1;
   wire out2;
   wire out3;
   reg  clk = 1'b0;
   reg  in = 1'b0;

   delay #(1) dl1_uut
     (.out (out1),

      .clk (clk),
      .in  (in)
     );

   delay #(2) dl2_uut
     (.out (out2),

      .clk (clk),
      .in  (in)
     );

   delay #(1) dl4_uut
     (.out (out3),

      .clk (clk),
      .in  (out1)
     );

   initial begin
      $dumpfile("delay.vcd");
      $dumpvars(1, delay_tb);

      #120 $finish;
   end

   always #5 clk = ~clk;

   always begin
      #10 in = 1'b1;
      #10 in = 1'b0;
      #20 in = 1'b1;
      #20 in = 1'b0;
      #30 in = 1'b1;
      #10 in = 1'b0;
   end

endmodule
