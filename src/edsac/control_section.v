/* Top module for Control Section L1 subsystem.
 */

module control_section (
  // Initial Order Loader or Starter.
  output wire s2,

  input wire  ep9,
  input wire  reset_cntr_neg, // From Starter Unit. Active low.
  input wire  starter,
  input wire  starter_neg,
  input wire  reset_sct_neg // From Starter Unit. Active low.

  // Computer.
  output wire g1_pos, // Indicates odd cycle.
  output wire g1_neg, // Indicates even cycle.
  output wire ev_d1_dz, // Used in Complementer/Collater when inserting trailing ones in a negated number
  output wire ev_d1,
  output wire da_m,
  output wire ds,
  output wire g5, // Accumulator shifting gate.
  output wire g6_pos, // Used in Multiplicand Tank for gating.
  output wire ccu_ones,
  output wire g2_pos, // Multiplicand and shifting gate.
  output wire g2_neg, // Inverse Multiplicand and shifting gate.
  output wire g3_pos, // Controls output from Multiplicand Tank to Adder.
  output wire g4_pos, // Complementer gate.
  output wire g4_neg,
  output wire g9_neg, // Accumulator clear gate.
  output wire g10_neg, // Multiplier clear gate.
  output wire g11_neg, // Multiplicand clear gate.
  output wire dv, // Sign test pulse for E order (jump if Acc >= 0), output to Accumulator.
  output wire jump_uc,
  output wire r2, // Stimulating pulse received from MCU, indicates completion of loading.
                  // To Multiplier, Printer and Tape Reader.
xx  output wire g12, // Indicates Stage 1 of main control in progress. To Multiplicand.
  output wire g13, // Indicates Stage 2 of main control in progress. To Multiplicand.
xx  output wire f1_neg, // Inverted order bit 1 indicating instruction length. To ASU 1.
  output wire mib, // To Multiplier and Multiplicand.

  input wire  mcand_in,
  input wire  da_n, // From Multiplicand.
  input wire  ds_r, // Sign bit propagation for right shifts, produced 
                    // in Accumulator in response to ds (coming from CCU 2).
  input wire  ep4, // From the Multiplier.
  input wire  dx_m, // Response to digit test pulse (dx), signalled when corresponding bit is 1.
                    // From the Multiplier.
  input wire  dv_d, // Response to dv pulse sent by CCU 10 to Accumulator.
                    // From Accumulator.
  output wire dx, // Digit test pulse for Multiplier.

  // Digit Pulse Generator.
  input wire  d0,
  input wire  d1,
  input wire  d2,
  input wire  d7,
  input wire  d18,
xx  input wire  d19,
xx  input wire  d20,
xx  input wire  d25,
xx  input wire  d26,
xx  input wire  d27,
xx  input wire  d28,
xx  input wire  d29,
  input wire  d31,
  input wire  d32,
  input wire  d33,
  input wire  d34,
  input wire  d35,

  // Printer ad Tape Reader.
  output wire ep_done, // From MCU.

  input wire  ep10,
  input wire  ep8,
  input wire  stop_one_a,
  input wire  stop_one_c,

  // Order Coder.
  output wire c1, // To Multiplicand.
  output wire c2, // To Complementer-Collater.
  output wire c3, // To Complementer-Collater.
  output wire c4, // To Complementer-Collater.
  output wire c7, // To Complementer-Collater and ASU 1.
  output wire c8, // To ASU 1.
  output wire c9, // To Complementer-Collater.
  output wire c10, // To Accumulator.
  output wire c16, // To Tape Reader.
  output wire c18, // To Multiplier.
  output wire c19, // To ASU 1.
  output wire c21, // To Multiplicand and Printer.
  output wire c25, // To Accumulator.

  // Memory Unit. All the signals in this section are referenced in memory_top.v.
  output wire f1_down_t0_clr,
  output wire f1_up_t0_clr,
  output wire f1_down_t1_clr,
  output wire f1_up_t1_clr,
  output wire f1_down_t2_clr,
  output wire f1_up_t2_clr,
  output wire f1_down_t3_clr,
  output wire f1_up_t3_clr,
  output wire f2_down_t0_clr,
  output wire f2_up_t0_clr,
  output wire f2_down_t1_clr,
  output wire f2_up_t1_clr,
  output wire f2_down_t2_clr,
  output wire f2_up_t2_clr,
  output wire f2_down_t3_clr,
  output wire f2_up_t3_clr,
  output wire r1_down_t0_clr,
  output wire r1_up_t0_clr,
  output wire r1_down_t1_clr,
  output wire r1_up_t1_clr,
  output wire r1_down_t2_clr,
  output wire r1_up_t2_clr,
  output wire r1_down_t3_clr,
  output wire r1_up_t3_clr,
  output wire r2_down_t0_clr,
  output wire r2_up_t0_clr,
  output wire r2_down_t1_clr,
  output wire r2_up_t1_clr,
  output wire r2_down_t2_clr,
  output wire r2_up_t2_clr,
  output wire r2_down_t3_clr,
  output wire r2_up_t3_clr,
  output wire f1_mib,
  output wire f2_mib,
  output wire r1_mib,
  output wire r2_mib,
  output wire f1_up_t0_in,
  output wire f1_up_t1_in,
  output wire f1_up_t2_in,
  output wire f1_up_t3_in,
  output wire f1_down_t0_in,
  output wire f1_down_t1_in,
  output wire f1_down_t2_in,
  output wire f1_down_t3_in,
  output wire f1_up_t0_out,
  output wire f1_up_t1_out,
  output wire f1_up_t2_out,
  output wire f1_up_t3_out,
  output wire f1_down_t0_out,
  output wire f1_down_t1_out,
  output wire f1_down_t2_out,
  output wire f1_down_t3_out,
  output wire f2_up_t0_in,
  output wire f2_up_t1_in,
  output wire f2_up_t2_in,
  output wire f2_up_t3_in,
  output wire f2_down_t0_in,
  output wire f2_down_t1_in,
  output wire f2_down_t2_in,
  output wire f2_down_t3_in,
  output wire f2_up_t0_out,
  output wire f2_up_t1_out,
  output wire f2_up_t2_out,
  output wire f2_up_t3_out,
  output wire f2_down_t0_out,
  output wire f2_down_t1_out,
  output wire f2_down_t2_out,
  output wire f2_down_t3_out,
  output wire r1_up_t0_in,
  output wire r1_up_t1_in,
  output wire r1_up_t2_in,
  output wire r1_up_t3_in,
  output wire r1_down_t0_in,
  output wire r1_down_t1_in,
  output wire r1_down_t2_in,
  output wire r1_down_t3_in,
  output wire r1_up_t0_out,
  output wire r1_up_t1_out,
  output wire r1_up_t2_out,
  output wire r1_up_t3_out,
  output wire r1_down_t0_out,
  output wire r1_down_t1_out,
  output wire r1_down_t2_out,
  output wire r1_down_t3_out,
  output wire r2_up_t0_in,
  output wire r2_up_t1_in,
  output wire r2_up_t2_in,
  output wire r2_up_t3_in,
  output wire r2_down_t0_in,
  output wire r2_down_t1_in,
  output wire r2_down_t2_in,
  output wire r2_down_t3_in,
  output wire r2_up_t0_out,
  output wire r2_up_t1_out,
  output wire r2_up_t2_out,
  output wire r2_up_t3_out,
  output wire r2_down_t0_out,
  output wire r2_down_t1_out,
  output wire r2_down_t2_out,
  output wire r2_down_t3_out,

  input wire  f1_down_mob_t0,
  input wire  f1_up_mob_t0,
  input wire  f1_down_mob_t1,
  input wire  f1_up_mob_t1,
  input wire  f1_down_mob_t2,
  input wire  f1_up_mob_t2,
  input wire  f1_down_mob_t3,
  input wire  f1_up_mob_t3,
  input wire  f2_down_mob_t0,
  input wire  f2_up_mob_t0,
  input wire  f2_down_mob_t1,
  input wire  f2_up_mob_t1,
  input wire  f2_down_mob_t2,
  input wire  f2_up_mob_t2,
  input wire  f2_down_mob_t3,
  input wire  f2_up_mob_t3,
  input wire  r1_down_mob_t0,
  input wire  r1_up_mob_t0,
  input wire  r1_down_mob_t1,
  input wire  r1_up_mob_t1,
  input wire  r1_down_mob_t2,
  input wire  r1_up_mob_t2,
  input wire  r1_down_mob_t3,
  input wire  r1_up_mob_t3,
  input wire  r2_down_mob_t0,
  input wire  r2_up_mob_t0,
  input wire  r2_down_mob_t1,
  input wire  r2_up_mob_t1,
  input wire  r2_down_mob_t2,
  input wire  r2_up_mob_t2,
  input wire  r2_down_mob_t3,
  input wire  r2_up_mob_t3,

  // Transfer Unit.
  input wire mob_asu1,
  input wire mob_tape,
  input wire mob_starter,
  input wire mob_printer,

  input wire  clk
  );

  wire f1_pos;
  wire f2_pos;
  wire f7_pos;
  wire f8_pos;
  wire f9_pos;
  wire f10_pos;
  wire f11_pos;
  wire epsep;
  wire order_sct;

  tank_flash tank_flash (
    .f1_pos    (f1_pos),
    .f1_neg    (f1_neg),
    .f2_pos    (f2_pos),
    .f7_pos    (f7_pos),
    .f8_pos    (f8_pos),
    .f9_pos    (f9_pos),
    .f10_pos   (f10_pos),
    .f11_pos   (f11_pos),

    .d19       (d19),
    .d20       (d20),
    .d25       (d25),
    .d26       (d26),
    .d27       (d27),
    .d28       (d28),
    .d29       (d29),
    .epsep     (epsep),
    .g12       (g12),
    .order_sct (order_sct),
    );
endmodule
