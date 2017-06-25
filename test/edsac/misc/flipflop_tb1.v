module flipflop_tb1();
   reg  set;
   reg  reset;
   reg  clk1;
   reg  clk2;
   reg  [1:0] count;
   wire out;
   wire out_bar;

   flipflop ff
     (.out     (out),
      .out_bar (out_bar),
      .set     (clk2),
      .reset   (clk1)
     );

   initial begin
      $dumpfile("flipflop_1.vcd");
      $dumpvars(1, flipflop_tb1);
      clk1 = 1'b0;
      clk2 = 1'b0;
      count[1:0] = 2'b00;
      #200 $finish;
   end

   always begin
      #5 clk1 = ~clk1;
   end

   always @(posedge clk1) begin
      count[1:0] <= count[1:0] + 2'b01;
   end

   always begin
      if (count[1])
        #15 clk2 = ~clk2;
      else
        #10 clk2 = ~clk2;
   end

endmodule
