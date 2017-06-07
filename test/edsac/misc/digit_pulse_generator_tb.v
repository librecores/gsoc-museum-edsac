module digit_pulse_generator_tb();

   reg         clk = 1'b0;
   wire [35:0] digit_pulse;

   initial begin
      $dumpfile("digit_pulse_generator.vcd");
      $dumpvars(1, digit_pulse_generator_tb);
      #2100 $finish;
   end

   digit_pulse_generator dpg
     (.digit_pulse (digit_pulse),
      .clk         (clk)
     );

   always #5 clk = ~clk;

endmodule
