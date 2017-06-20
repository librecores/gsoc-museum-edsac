/* Top module for Computer L1 subsystem.
 */

module computer
  (// Computer Control Unit (CCU).
   output wire mcand_in, // Access to data going into Multiplicand.
   output wire da_n, // Result of test Multiplicand sign.
   output wire dx_m, // Response to digit test pulse (dx), signalled when corresponding bit is 1.
   output wire ep4, // End Pulse for load multiplier order.
   output wire ds_r, // Sign bit propagation for right shifts.

   // Main Control Unit (MCU) and Computer Control Unit (CCU).
   output wire dv_d, // Jump condition satisfied.

   // Transfer Unit (XFR).
   output wire mob, // Main Output Bus.

   // Clock and Digit Pulse Generator (DPG).
   input wire  clk,
   input wire  d0,
   input wire  d17,
   input wire  d35,

   // Order Coder.
   input wire  c1, // For A, S, C, V, N orders - operations that require number from memory.
   input wire  c2, // A order - add number into accumulator.
   input wire  c3, // S order - subtract.
   input wire  c4, // C order - collate with Multiplier and add into accumulator.
   input wire  c7, // Right shift.
   input wire  c8, // Left shift.
   input wire  c9, // X, Y orders.
   input wire  c10, // G order - jump if accumulator negative (< 0).
   input wire  c18, // H order - transfer number from memory into Multiplier.
   input wire  c19, // Store instructions T, U.
   input wire  c21, // O order.
   input wire  c25, // E order - jump is accumulator positive (>= 0).

   // Main Control Unit (MCU).
   input wire  g12, // Stage 1 of Main Control.
   input wire  g13, // Stage 2 of Main Control.
   input wire  r2, // Stimulating pulse, indicates completion of loading.

   // Timing Control Tank and Shifting Unit (TCTSU).
   input wire  g2_pos, // Multiplicand and Shifting gate.
   input wire  g2_neg,
   input wire  dx, // Digit test pulse for Multiplier.

   // Computer Control Unit (CCU).
   input wire  g1_pos, // Odd cycles gate.
   input wire  g1_neg, // Even cycles gate.
   input wire  g3_pos, // Multiplicand output.
   input wire  g4_pos, // Complementer gate.
   input wire  g4_neg,
   input wire  g5, // Accumulator shifting gate.
   input wire  g6_pos, // Multiplicand shift for A, S, C orders.
   input wire  g9_neg, // Accumulator clear gate.
   input wire  g10_neg, // Inverse Multiplier clear gate.
   input wire  g11_neg, // Inverse multiplicand clear gate.
   input wire  da_m, // Sign test pulse for Multiplicand, originating in CCU 2.
   input wire  ccu_ones, // Sign insertion/propagation pulses.
   input wire  ev_d1_dz, // Logic diagram describes as, "early d1 during 
                         // even cycles to stop inserting ones".
   input wire  ds, // Sign test for right shifts.
   input wire  dv, // Sign test for E-order.
   input wire  jump_uc,

   // Tank Number Flashing Unit (TFL).
   input wire  f1_neg, // Indicates instruction length.

   // Transfer Unit (XFR).
   input wire  mib // Main Input Bus.
  );

endmodule
