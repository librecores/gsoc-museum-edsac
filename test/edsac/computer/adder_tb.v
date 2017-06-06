`timescale 1ns / 1ps

module adder_tb();

   wire sum;
   wire carry;
   reg  clk = 1'b0;
   reg  a;
   reg  b;

   adder adder_uut
     (.sum (sum),

      .clk (clk),
      .a   (a),
      .b   (b)
     );

   initial begin
      $dumpfile("adder.vcd");
      $dumpvars(1, adder_tb);

      #160 $finish;
   end

   always #5 clk = ~clk;

   always begin
      a = 1'b0;
      #10 a = 1'b1;
      #10 a = 1'b0;
      #10 a = 1'b1;
      #20 a = 1'b0;
      #10 a = 1'b1;
      #30 a = 1'b0;
      #10 a = 1'b1;
      #10 a = 1'b0;
      #40;
   end

   always begin
      b = 1'b1;
      #20 b = 1'b0;
      #20 b = 1'b1;
      #10 b = 1'b0;
      #10 b = 1'b1;
      #20 b = 1'b0;
      #20 b = 1'b1;
      #20 b = 1'b0;
      #30;
   end

endmodule
