module flipflop_tb();
   reg  set;
   reg  reset;
   wire out;
   wire out_bar;

   flipflop ff
     (.out     (out),
      .out_bar (out_bar),
      .set     (set),
      .reset   (reset)
     );

   initial begin
      $dumpfile("flipflop.vcd");
      $dumpvars(1, flipflop_tb);
      set = 1'b0;
      reset = 1'b0;
      #20 set = 1'b1;
      #1 set = 1'b0;
      #40 set = 1'b1;
      #5 set = 1'b0;
      #7 reset = 1'b1;
      #3 reset = 1'b0;
      #14 reset = 1'b1;
      #3 reset = 1'b0;
      #21 set = 1'b1;
      #2 set = 1'b0;
      #9 reset = 1'b1;
      #9 reset = 1'b0;
      #45 $finish;
   end

endmodule
