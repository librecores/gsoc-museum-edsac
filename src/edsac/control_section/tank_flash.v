/* Flipflops in Tank Number Flashing Unit are set by gating either 
 * SCT (Stage 1 of main control) or Order (from Order Tank, Stage 2 
 * of main control).
 * 
 * TODO: Resetting arrangement NOT clear.
 */

module tank_flash
  (output wire f1_pos, // Indicats instruction length.
   output wire f1_neg,
   output wire f2_pos, // Indicates odd or even short word.
   output wire f7_pos, // Tank address bit 7. To Tank Decoder 2 (final stage).
   output wire f8_pos, // Tank address bit 8. To Tank Decoder 2 (final stage).
   output wire f9_pos, // Tank address bit 9.  To Tank Decoder 1 (second stage).
   output wire f10_pos, // Tank address bit 10. To Tank Decoder 0 (first stage).
   output wire f11_pos, // Tank address bit 11. To Tank Decoder 0 (first stage).

   input wire  d19,
   input wire  d20,
   input wire  d25,
   input wire  d26,
   input wire  d27,
   input wire  d28,
   input wire  d29,
   input wire  epsep,
   input wire  g12, // Stage 1 of main control.
   input wire  order_sct
  );

   wire reset;
   wire set11;
   wire set10;
   wire set9;
   wire set8;
   wire set7;
   wire set2;
   wire set1;

   flipflop ff11
     (.out     (f11_pos),
      .out_bar (), // Unconnected.
      .set     (set11),
      .reset   (reset)
     );

   flipflop ff10
     (.out     (f10_pos),
      .out_bar (), // Unconnected.
      .set     (set10),
      .reset   (reset)
     );

   flipflop ff9
     (.out     (f9_pos),
      .out_bar (), // Unconnected.
      .set     (set9),
      .reset   (reset)
     );

   flipflop ff8
     (.out     (f8_pos),
      .out_bar (), // Unconnected.
      .set     (set8),
      .reset   (reset)
     );

   flipflop ff7
     (.out     (f7_pos),
      .out_bar (), // Unconnected.
      .set     (set7),
      .reset   (reset)
     );

   flipflop ff2
     (.out     (f2_pos),
      .out_bar (), // Unconnected.
      .set     (set2),
      .reset   (reset)
     );

   flipflop ff1
     (.out     (f1_pos),
      .out_bar (f1_neg),
      .set     (set1),
      .reset   (reset)
     );

   assign set11 = order_sct & d29;
   assign set10 = order_sct & d28;
   assign set9  = order_sct & d27;
   assign set8  = order_sct & d26;
   assign set7  = order_sct & d25;
   assign set2  = order_sct & d20;
   assign set1  = order_sct & d19;

   assign reset = epsep | ~g12;

endmodule
