/* Top module for Computer L1 subsystem.
 */

module computer (
  // Computer Control Unit (CCU).
  output wire mcand_in, // Access to data going into Multiplicand.
  output wire da_n, // Result of test Multiplicand sign.
  output wire dx_m, // Response to digit test pulse (dx), signalled when corresponding bit is 1.
  output wire ep4, // End Pulse for load multiplier order.
  output wire ds_r, // Sign bit propagation for right shifts.

  // Main Control Unit (MCU) and Computer Control Unit (CCU).
  output wire dv_d, // Jump condition satisfied.

  // Transfer Unit (XFR).
  output wire mob, // Main Output Bus.

  input wire  mib, // Main Input Bus.

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
  input wire  f1_neg // Indicates instruction length - f1_pos, when high, indicates a full word.
  );

  wire       adder_sum, adder_a, adder_b;
  wire       acc, acc1;
  wire       mcand, mplier;
  wire [3:0] x; // Gating EMFs from ASU I to ADU II. x[0] corresponds 
                // to x1 of original logic, x[1] to x2 and so on.

  accumulator accumulator (
    .acc       (acc),
    .acc1      (acc1),
    .ds_r      (ds_r),
    .dv_d      (dv_d),

    .clk       (clk),
    .adder_sum (adder_sum),
    .c10       (c10),
    .c25       (c25),
    .ds        (ds),
    .dv        (dv),
    .g1_pos    (g1_pos),
    .g1_neg    (g1_neg),
    .g9_neg    (g9_neg),
    .jump_uc   (jump_uc)
    );

  acc_shift_i acc_shift_i (
    .mob8   (mob),
    .x      (x[3:0]),

    .clk    (clk),
    .g5     (g5),
    .c7     (c7),
    .c8     (c8),
    .c19    (c19),
    .acc    (acc),
    .g13    (g13),
    .d17    (d17),
    .d35    (d35),
    .f1_neg (f1_neg)
    );

  acc_shift_ii acc_shift_ii (
    .adder_a (adder_a),

    .clk     (clk),
    .acc1    (acc1),
    .x       (x[3:0])
    );

  adder adder (
    .sum (adder_sum),

    .clk (clk),
    .a   (adder_a),
    .b   (adder_b)
    );

  compl_collater compl_collater (
    .adder_b  (adder_b),

    .clk      (clk),
    .c2       (c2),
    .c3       (c3),
    .c4       (c4),
    .c7       (c7),
    .c9       (c9),
    .ccu_ones (ccu_ones),
    .ev_d1_dz (ev_d1_dz),
    .g4_pos   (g4_pos),
    .g4_neg   (g4_neg),
    .mcand    (mcand),
    .mplier   (mplier)
    );

  multiplicand multiplicand (
    .da_n     (da_n),
    .mcand    (mcand),
    .mcand_in (mcand_in),

    .clk      (clk),
    .c1       (c1),
    .c21      (c21),
    .da_m     (da_m),
    .g2_pos   (g2_pos),
    .g2_neg   (g2_neg),
    .g3_pos   (g3_pos),
    .g6_pos   (g6_pos),
    .g11_neg  (g11_neg),
    .g12      (g12),
    .g13      (g13),
    .mib      (mib)
    );

  multiplier multiplier (
    .mpier   (mplier),
    .dx_m    (dx_m),
    .ep4     (ep4),

    .clk     (clk),
    .c18     (c18),
    .mib     (mib),
    .g10_neg (g10_neg),
    .dx      (dx),
    .d0      (d0),
    .r2      (r2)
    );

endmodule
