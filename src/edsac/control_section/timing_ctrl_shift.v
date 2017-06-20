/* Timing Control Tank and Shifting Unit. ev_d0 from CCU 2 is admitted in as zero_d0 
 * into the Tank. This recirculates via two feedback paths, one of which introduces 
 * an additional delay of 1 p.i. So every two minor cycles, the pulse is delayed to 
 * arrive 1 p.i. later. Together these two pulse form dx and dy - dx indicating start 
 * and dy coming in 1 M/C + 1 p.i. later indicating end.
 * 
 * TODO: The original report mentions Timing Control Tank and Shifting Unit 
 *       separately, but logic diagrams have combined the two. Here, perhaps 
 *       for now, they are combined.
 */

module timing_ctrl_shift
  (output wire seventy_d35,
   output wire da, // Sign test pulse for Multiplicand (via CCU 2).
   output wire dx, // Digit test pulse for Multiplier.
   output wire dy, // Resetting pulse after addition of partial product.
   output wire g2_pos, // Multiplicand and shifting gate.
   output wire g2_neg, // Inverse Multiplicand and shifting gate.

   input wire  clk,
   input wire  c5, // V, N orders - multiply and add/subtract (V/N).
   input wire  c6, // R, L order - right and left shift respectively.
   input wire  zero_d0,
   input wire  d35
  );

   wire g2_pos_del;
   wire g2_neg_del;
   wire timing_store_in;
   wire timing_store_out;
   wire ff_set;

   assign ff_set = (timing_store_out & (c5 | c6) & g2_neg_del) | zero_d0;
   assign da = g2_pos_del & timing_store_out;

   flipflop ff_g2
     (.out     (g2_pos),
      .out_bar (g2_neg),
      .set     (ff_set),
      .reset   (dy)
     );

   assign timing_store_in = dy | ff_set;

   // 1 M/C (36 p.i.) 72 us delay tank.
   delay #(.INTERVAL(36)) timing_store
     (.out (timing_store_out),
      .clk (clk),
      .in  (timing_store_in)
     );

   // 1 p.i. delay that generates successive dy pulses.
   delay #(.INTERVAL(1)) dl_dy
     (.out (dy),
      .clk (clk),
      .in  (da)
     );

   delay #(.INTERVAL(1)) dl_pos
     (.out (g2_pos_del),
      .clk (clk),
      .in  (g2_pos)
     );

   delay #(.INTERVAL(1)) dl_neg
     (.out (g2_neg_del),
      .clk (clk),
      .in  (g2_neg)
     );

   assign dx = ff_set & c5;
   assign seventy_d35 = d35 & ff_set;

endmodule
