module ccu_1_tb();

   reg         clk = 1'b0;
   wire [35:0] d;
   wire        g1_pos;
   wire        g1_neg;
   wire        odd_d0;
   wire        odd_d35;
   wire        ev_d0;
   wire        ev_d1;
   wire        ev_d1_dz;
   reg         dy;
   reg         da_n;

   digit_pulse_generator dpg
     (.digit_pulse (d),
      .clk         (clk)
     );

   ccu_1 ccu_1_uut
     (.g1_pos   (g1_pos),
      .g1_neg   (g1_neg),
      .odd_d0   (odd_d0),
      .odd_d35  (odd_d35),
      .ev_d0    (ev_d0),
      .ev_d1    (ev_d1),
      .ev_d1_dz (ev_d1_dz),

      .clk      (clk),
      .d0       (d[0]),
      .d1       (d[1]),
      .d18      (d[18]),
      .d35      (d[35]),
      .da_n     (da_n),
      .dy       (dy)
     );

   initial begin
      $dumpfile("ccu_1.vcd");
      $dumpvars(1, ccu_1_tb);
      #1200 $finish;
   end

   always #5 clk = ~clk;

endmodule
