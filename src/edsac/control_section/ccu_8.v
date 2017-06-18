/* CCU 8 is concerned with multiplication and shift operations.
 * 
 * TODO: Significant timing issues exist, refer to comments below.
 * 
 * TODO: Logic diagrams show additional logic units using ep_done 
 *       and ep1 signals, but it remains unconnected in the diagram 
 *       so is not implemented here.
 */

module ccu_8
  (output wire ep1, // End pulse for multiplication operation.
   output wire g4_pos, // Complementer gate.
   output wire g4_neg,
   output wire ones2, // Sign propagation.

   input wire  seventy_d35,
   input wire  c11, // N order - multiply and subtract.
   input wire  c14, // V order - multiply and add.
   input wire  da, // Sign test pulse for Multiplicand. Unused, refer 
                   // comment below at ep1 assignment.
   input wire  ds_r, // Sign bit propagation for right shifts, produced 
                     // in Accumulator in response to ds (coming from CCU 2).
   input wire  dy, // TODO: Mentioned as input in logic diagram, but 
                   // is NOT connected anywhere in the diagram, but is used here below.
   input wire  ep_done, // From MCU. Unused currently, refer to comment at top.
   input wire  ev_d0,
   input wire  odd_d35,
   input wire  g5, // Accumulator shifting gate.
   input wire  reset_shift_ff // Resets a flipflop here, originates in CCU 3.
  );

   wire n_out;
   wire n_out_bar;
   wire ff_ones2_out;

   flipflop ff_ones2
     (.out     (ff_ones2_out),
      .out_bar (), // Unconnected.
      .set     (ds_r),
      .reset   (reset_shift_ff)
     );

   // TODO: Logic diagram shows slight delay before output of ones2.
   // TODO: Logic diagram description says a delayed ev_d0 is used, 
   //       but the diagram itself uses odd_d35.
   assign ones2 = g5 & odd_d35 & ff_ones2_out;

   flipflop ff_n_order
     (.out     (n_out),
      .out_bar (n_out_bar),
      .set     (seventy_d35),
      .reset   (ep1)
     );

   assign g4_pos = (c14 & n_out_bar) | (c11 & n_out);
   assign g4_neg = (c14 & n_out) | (c11 & n_out_bar);

   // TODO: Logic diagram description says ep1 is raised by dy pulse appearing 
   //       at the same time as ev_d0, however, the diagram itself uses a delayed
   //       da (mentioned in a comment above that dy is unconnected). The description
   //       is assumed to be correct over the diagram and hence the following.
   assign ep1 = ev_d0 & dy;

endmodule
