/* Part of multiplication logic. Controls 
 * Multiplicand output gate and sign propagation.
 * 
 * TODO: The final output of ones1 is reshaped with 
 *       clk. Is this going to be necessary?
 * 
 * TODO: Significant confusion with timing of this 
 *       unit exists (refer comments below).
 */

module ccu_7
  (output wire g3_pos, // Controls output from Multiplicand Tank to Adder.
   output wire ones1, // Sign propagation for multiplication.

   input wire  clk,
   input wire  dx_m, // Response to digit test pulse (dx), signalled when corresponding bit is 1.
   input wire  dy, // Resetting pulse after addition of partial product.
   input wire  da_n,
   input wire  ev_d0
  );

   wire dl1_out;
   wire ev_d1;
   wire ff2_set;
   wire ff2_out;

   flipflop ff1
     (.out     (g3_pos),
      .out_bar (), // Unconnected.
      .set     (dx_m),
      .reset   (dy)
     );

   delay #(.INTERVAL(1)) dl1
     (.out (dl1_out),
      .clk (clk),
      .in  (g3_pos)
     );

   // TODO: Logic diagram shows slight delay prior to admittance of da_n.
   assign ff2_set = da_n & dl1_out;

   // Generate an ev_d1 to reset ff2.
   // TODO: Logic diagram shows odd_d35 (delayed slightly) and report 
   // says ev_d1 resets ff2. There is confusion as to which to use, 
   // and also with general timing here.
   delay #(.INTERVAL(1)) dl2
     (.out (ev_d1),
      .clk (clk),
      .in  (ev_d0)
     );

   flipflop ff2
     (.out     (ff2_out),
      .out_bar (), // Unconnected.
      .set     (ff2_set),
      .reset   (ev_d1)
     );

   // TODO: Logic diagram shows a small LC delay before output of ones1.
   assign ones1 = ff2_out & clk;

endmodule
