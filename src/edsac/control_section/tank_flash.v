/* Flipflops in Tank Number Flashing Unit are set by gating either 
 * SCT (Stage 1 of main control) or Order (from Order Tank, Stage 2 
 * of main control). The Tank Number Flashing Unit is responsivble 
 * for selecting and providing a route to a particular tank (while CU 
 * is responsible to select the position within the 16 minor cycles 
 * the tank).
 * 
 * Clearly, the Tank Number Flashing Unit needs to be engaged 
 * in both Stage I (instruction fetch) and Stage II (instruction 
 * execution) of main control. EPSEP resets flipflops at end of Stage II, 
 * while inverted g12 resets flipflops at end of Stage I.
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
   input wire  epsep, // Indicates end of Stage II
   input wire  g12, // Stage 1 of main control.
   input wire  order_sct
  );

   wire       reset;
   wire [6:0] tank_addr;

   // Tank address flipflops.
   flipflop ff11
     (.out     (f11_pos),
      .out_bar (), // Unconnected.
      .set     (tank_addr[4]),
      .reset   (reset)
     );
   flipflop ff10
     (.out     (f10_pos),
      .out_bar (), // Unconnected.
      .set     (tank_addr[3]),
      .reset   (reset)
     );
   flipflop ff9
     (.out     (f9_pos),
      .out_bar (), // Unconnected.
      .set     (tank_addr[2]),
      .reset   (reset)
     );
   flipflop ff8
     (.out     (f8_pos),
      .out_bar (), // Unconnected.
      .set     (tank_addr[1]),
      .reset   (reset)
     );
   flipflop ff7
     (.out     (f7_pos),
      .out_bar (), // Unconnected.
      .set     (tank_addr[0]),
      .reset   (reset)
     );

   // Odd or even short word.
   flipflop ff2
     (.out     (f2_pos),
      .out_bar (), // Unconnected.
      .set     (tank_addr[5]),
      .reset   (reset)
     );

   // Instruction length.
   flipflop ff1
     (.out     (f1_pos),
      .out_bar (f1_neg),
      .set     (tank_addr[6]),
      .reset   (reset)
     );

   assign tank_addr[4:0] = {5{order_sct}} & {d29, d28, d27, d26, d25};
   assign tank_addr[6:5] = {2{order_sct}} & {d19, d20};

   assign reset = epsep | ~g12;

endmodule
