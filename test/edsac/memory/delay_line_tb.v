`timescale 1ns / 1ps

module delay_line_tb();

   wire [3:0] monitor;
   reg        clk = 1'b0;
   reg        data_in = 1'b0;
   reg        data_in_gate = 1'b0;
   reg        data_clr = 1'b1;

   delay_line #(2, 2) dl1 (
                           .monitor(monitor),
                           .clk(clk),
                           .data_in(data_in),
                           .data_in_gate(data_in_gate),
                           .data_clr(data_clr)
                           );

   initial begin
      $dumpfile("delay_line.vcd");
      $dumpvars(1, delay_line_tb);

      #17 data_in_gate = 1'b1;
      data_in = 1'b1;
      data_in = 1'b1;
      #19 data_in = 1'b0;
      #24 data_in_gate = 1'b0;
      #13 data_clr = 1'b0;
      #66 data_clr = 1'b1;
      #43 $finish;
   end

   always #5 clk = ~clk;

endmodule
