/* Flipflops in Order Flashing Unit are set by gating Order from Order 
 * Tank, Stage 2 of main control, instruction execution. Order is gated 
 * with g13 (Stage 2 of main control) in the Order Tank, so the flipflops 
 * are set up right after Stage 2 commences.
 */

module order_flash
  (output wire f13_pos, // Order bit 13 (opcode bit 0, least significant).
   output wire f13_neg,
   output wire f14_pos, // Order bit 14 (opcode bit 1).
   output wire f14_neg,
   output wire f15_pos, // Order bit 15 (opcode bit 2).
   output wire f15_neg,
   output wire f16_pos, // Order bit 16 (opcode bit 3).
   output wire f16_neg,
   output wire f17_pos, // Order bit 17 (opcode bit 4, most significant).
   output wire f17_neg,
   output wire order_flash_rdy, // Indicates Order Flashing flipflops are set.

   input wire  d31,
   input wire  d32,
   input wire  d33,
   input wire  d34,
   input wire  d35,
   input wire  g13, // Stage 2 of main control.
   input wire  epsep, // Indicates end of Stage 2.
   input wire  order // Order pulse train from Order Tank.
  );

   wire [4:0] opcode_bit;
   wire       ofl_rdy_in;

   // Opcode flipflops
   flipflop ff13
     (.out     (f13_pos),
      .out_bar (f13_neg),
      .set     (opcode_bit[0]),
      .reset   (epsep)
     );
   flipflop ff14
     (.out     (f14_pos),
      .out_bar (f14_neg),
      .set     (opcode_bit[1]),
      .reset   (epsep)
     );
   flipflop ff15
     (.out     (f15_pos),
      .out_bar (f15_neg),
      .set     (opcode_bit[2]),
      .reset   (epsep)
     );
   flipflop ff16
     (.out     (f16_pos),
      .out_bar (f16_neg),
      .set     (opcode_bit[3]),
      .reset   (epsep)
     );
   flipflop ff17
     (.out     (f17_pos),
      .out_bar (f17_neg),
      .set     (opcode_bit[4]),
      .reset   (epsep)
     );

   // Order Flashing Unit ready flipflop.
   flipflop ff_order_flash_rdy
     (.out     (order_flash_rdy),
      .out_bar (), // Unconnected.
      .set     (ofl_rdy_in),
      .reset   (epsep)
     );

   assign opcode_bit[4:0] = {5{order}} & {d35, d34, d33, d32, d31};
   assign ofl_rdy_in      = d35 & g13;

endmodule
