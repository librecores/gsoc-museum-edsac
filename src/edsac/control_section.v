/* Top module for Control Section L1 subsystem.
 */

module control_section (
  // Initial Order Loader or Starter.
  output wire s2,

  input wire  ep9,
  input wire  reset_cntr_neg, // From Starter Unit. Active low.
  input wire  starter,
  input wire  starter_neg,
  input wire  reset_sct_neg, // From Starter Unit. Active low.

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
  output wire g12, // Indicates Stage 1 of main control in progress. To Multiplicand.
  output wire g13, // Indicates Stage 2 of main control in progress. To Multiplicand.
  output wire f1_neg, // Inverted order bit 1 indicating instruction length. To ASU 1.
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
  input wire  d19,
  input wire  d20,
  input wire  d25,
  input wire  d26,
  input wire  d27,
  input wire  d28,
  input wire  d29,
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
  wire f10_pos; // Tank address bit 10.
  wire f11_pos; // Tank address bit 11.
  wire epsep;
  wire order_sct;
  wire f1_read;
  wire f1_write;
  wire f2_read;
  wire f2_write;
  wire r1_read;
  wire r1_write;
  wire r2_read;
  wire r2_write;
  wire cu_gate_pos;
  wire cu_gate_neg;
  wire f1_mob;
  wire f2_mob;
  wire r1_mob;
  wire r2_mob;
  wire f1_down_in;
  wire f1_up_in;
  wire f1_down_out;
  wire f1_up_out;
  wire r1_down_in;
  wire r1_up_in;
  wire r1_down_out;
  wire r1_up_out;
  wire f2_down_in;
  wire f2_up_in;
  wire f2_down_out;
  wire f2_up_out;
  wire r2_down_in;
  wire r2_up_in;
  wire r2_down_out;
  wire r2_up_out;
  wire f1_down_f7_pos;
  wire f1_down_f7_neg;
  wire f1_down_f8_pos;
  wire f1_down_f8_neg;
  wire f1_down_t_in;
  wire f1_down_t_out;
  wire f1_up_f7_pos;
  wire f1_up_f7_neg;
  wire f1_up_f8_pos;
  wire f1_up_f8_neg;
  wire f1_up_t_in;
  wire f1_up_t_out;
  wire f2_down_f7_pos;
  wire f2_down_f7_neg;
  wire f2_down_f8_pos;
  wire f2_down_f8_neg;
  wire f2_down_t_in;
  wire f2_down_t_out;
  wire f2_up_f7_pos;
  wire f2_up_f7_neg;
  wire f2_up_f8_pos;
  wire f2_up_f8_neg;
  wire f2_up_t_in;
  wire f2_up_t_out;
  wire r1_down_f7_pos;
  wire r1_down_f7_neg;
  wire r1_down_f8_pos;
  wire r1_down_f8_neg;
  wire r1_down_t_in;
  wire r1_down_t_out;
  wire r1_up_f7_pos;
  wire r1_up_f7_neg;
  wire r1_up_f8_pos;
  wire r1_up_f8_neg;
  wire r1_up_t_in;
  wire r1_up_t_out;
  wire r2_down_f7_pos;
  wire r2_down_f7_neg;
  wire r2_down_f8_pos;
  wire r2_down_f8_neg;
  wire r2_down_t_in;
  wire r2_down_t_out;
  wire r2_up_f7_pos;
  wire r2_up_f7_neg;
  wire r2_up_f8_pos;
  wire r2_up_f8_neg;
  wire r2_up_t_in;
  wire r2_up_t_out;
  wire f13_pos;
  wire f13_neg;
  wire f14_pos;
  wire f14_neg;
  wire f15_pos;
  wire f15_neg;
  wire f16_pos;
  wire f16_neg;
  wire f17_pos;
  wire f17_neg;
  wire order_flash_rdy;
  wire order;
  wire cntr;
  wire sct;
  wire s1;
  wire r_pulse;
  wire order_clr;
  wire eng_mode_neg;
  wire eng_order;
  wire sct_clear_gate;
  wire sct_in_gate;
  wire sct_one;
  wire ep;
  wire single_ep;
  wire stop_neg;
  wire stop_one_b;
  wire seventy_d35;
  wire da;
  wire dy;
  wire zero_d0;
  wire mob;
  wire o_dy_0;
  wire o_dy_1;
  wire o_dy_2;
  wire o_dy_3;
  wire op_a;
  wire op_b;
  wire op_blank;
  wire op_c;
  wire op_d;
  wire op_delta;
  wire op_e;
  wire op_erase;
  wire op_f;
  wire op_g;
  wire op_h;
  wire op_i;
  wire op_j;
  wire op_k;
  wire op_l;
  wire op_m;
  wire op_n;
  wire op_o;
  wire op_p;
  wire op_phi;
  wire op_pi;
  wire op_q;
  wire op_r;
  wire op_s;
  wire op_t;
  wire op_theta;
  wire op_u;
  wire op_v;
  wire op_w;
  wire op_x;
  wire op_y;
  wire op_z;
  wire c5;
  wire c6;
  wire c11;
  wire c12;
  wire c13;
  wire c14;
  wire c17;
  wire c17a; // F, I, T, U, Starter order.
  wire c20;
  wire c22;
  wire c24;
  wire c26;
  wire c27;
  wire extended_neg;
  wire odd_d0;
  wire odd_d35;
  wire ev_d0;
  wire g8;
  wire ep2;
  wire reset_shift_ff;
  wire ep3;
  wire ep0;
  wire ones4;
  wire ep1;
  wire ep5;
  wire ep6;
  wire ep7;
  wire ep11;
  wire ones1;
  wire ones2;

  ccu_1 ccu_1 (
    .g1_pos   (g1_pos),
    .g1_neg   (g1_neg),
    .odd_d0   (odd_d0),
    .odd_d35  (odd_d35),
    .ev_d0    (ev_d0),
    .ev_d1    (ev_d1),
    .ev_d1_dz (ev_d1_dz),

    .clk      (clk),
    .d0       (d0),
    .d1       (d1),
    .d18      (d18),
    .d35      (d35),
    .da_n     (da_n),
    .dy       (dy)
    );

  ccu_2 ccu_2 (
    .zero_d0  (zero_d0),
    .g8       (g8),
    .da_m     (da_m),
    .ds       (ds),

    .c7       (c7),
    .d35      (d35),
    .da       (da),
    .ev_d0    (ev_d0),
    .mcand_in (mcand_in),
    .c5       (c5),
    .c6       (c6),
    .s2       (s2)
    );

  ccu_3 ccu_3 (
    .ep2            (ep2),
    .g5             (g5),
    .reset_shift_ff (reset_shift_ff),

    .clk            (clk),
    .zero_d0        (zero_d0),
    .c6             (c6),
    .dy             (dy),
    .ev_d0          (ev_d0),
    .ev_d1          (ev_d1),
    .order          (order)
    );

  ccu_4 ccu_4 (
    .ep3    (ep3),
    .g6_pos (g6_pos),

    .clk    (clk),
    .c1     (c1),
    .ev_d0  (ev_d0),
    .odd_d0 (odd_d0),
    .g8     (g8),
    .r2     (r2)
    );

  ccu_5 ccu_5 (
    .ep0          (ep0),
    .ones4        (ones4),

    .clk          (clk),
    .c9           (c9),
    .c12          (c12),
    .c13          (c13),
    .d18          (d18),
    .ep_done      (ep_done),
    .ev_d0        (ev_d0),
    .extended_neg (extended_neg),
    .odd_d0       (odd_d0),
    .s2           (s2)
    );

  ccu_6 ccu_6 (
    .ep       (ep),
    .ccu_ones (ccu_ones),

    .ep0      (ep0),
    .ep1      (ep1),
    .ep2      (ep2),
    .ep3      (ep3),
    .ep4      (ep4),
    .ep5      (ep5),
    .ep6      (ep6),
    .ep7      (ep7),
    .ep8      (ep8),
    .ep9      (ep9),
    .ep10     (ep10),
    .ep11     (ep11),
    .ones1    (ones1),
    .ones2    (ones2),
    .ones4    (ones4)
    );

  /* Two most significant opcode bits are used to select 
   * one of the four second-level Order Decoder Units.
   */
  order_decoder1 order_decoder1 (
    .o_dy_0          (o_dy_0), // 00
    .o_dy_1          (o_dy_1), // 01
    .o_dy_2          (o_dy_2), // 10
    .o_dy_3          (o_dy_3), // 11

    .f16_pos         (f16_pos),
    .f16_neg         (f16_neg),
    .f17_pos         (f17_pos),
    .f17_neg         (f17_neg),
    .order_flash_rdy (order_flash_rdy)
    );

  /* Each of the following four instances of Order Decoder 2 
   * Unit (second level)uses the three least significant 
   * bits of the opcode.
   */
  order_decoder2 order_decoder2_0 (
    .op1     (op_p),  // 00 000
    .op2     (op_q),  // 00 001
    .op3     (op_w),  // 00 010
    .op4     (op_e),  // 00 011
    .op5     (op_r),  // 00 100
    .op6     (op_t),  // 00 101
    .op7     (op_y),  // 00 110
    .op8     (op_u),  // 00 111

    .f13_pos (f13_pos),
    .f13_neg (f13_neg),
    .f14_pos (f14_pos),
    .f14_neg (f14_neg),
    .f15_pos (f15_pos),
    .f15_neg (f15_neg),
    .o_dy    (o_dy_0)
    );

  order_decoder2 order_decoder2_1 (
    .op1     (op_i),      // 01 000
    .op2     (op_o),      // 01 001
    .op3     (op_j),      // 01 010
    .op4     (op_pi),     // 01 011
    .op5     (op_s),      // 01 100
    .op6     (op_z),      // 01 101
    .op7     (op_k),      // 01 110
    .op8     (op_erase),  // 01 111

    .f13_pos (f13_pos),
    .f13_neg (f13_neg),
    .f14_pos (f14_pos),
    .f14_neg (f14_neg),
    .f15_pos (f15_pos),
    .f15_neg (f15_neg),
    .o_dy    (o_dy_1)
    );

  order_decoder2 order_decoder2_2 (
    .op1     (op_blank),  // 10 000
    .op2     (op_f),      // 10 001
    .op3     (op_theta),  // 10 010
    .op4     (op_d),      // 10 011
    .op5     (op_phi),    // 10 100
    .op6     (op_h),      // 10 101
    .op7     (op_n),      // 10 110
    .op8     (op_m),      // 10 111

    .f13_pos (f13_pos),
    .f13_neg (f13_neg),
    .f14_pos (f14_pos),
    .f14_neg (f14_neg),
    .f15_pos (f15_pos),
    .f15_neg (f15_neg),
    .o_dy    (o_dy_2)
    );

  order_decoder2 order_decoder2_3 (
    .op1     (op_delta),  // 11 000
    .op2     (op_l),      // 11 001
    .op3     (op_x),      // 11 010
    .op4     (op_g),      // 11 011
    .op5     (op_a),      // 11 100
    .op6     (op_b),      // 11 101
    .op7     (op_c),      // 11 110
    .op8     (op_v),      // 11 111

    .f13_pos (f13_pos),
    .f13_neg (f13_neg),
    .f14_pos (f14_pos),
    .f14_neg (f14_neg),
    .f15_pos (f15_pos),
    .f15_neg (f15_neg),
    .o_dy    (o_dy_3)
    );

  order_coder order_coder (
    .c1   (c1),
    .c2   (c2),
    .c3   (c3),
    .c4   (c4),
    .c5   (c5),
    .c6   (c6),
    .c7   (c7),
    .c8   (c8),
    .c9   (c9),
    .c10  (c10),
    .c11  (c11),
    .c12  (c12),
    .c13  (c13),
    .c14  (c14),
    .c16  (c16),
    .c17  (c17),
    .c17a (c17a),
    .c18  (c18),
    .c19  (c19),
    .c20  (c20),
    .c21  (c21),
    .c22  (c22),
    .c24  (c24),
    .c25  (c25),
    .c26  (c26),
    .c27  (c27),

    .op_a         (op_a),
    .op_b         (op_b),
    .op_blank     (op_blank),
    .op_c         (op_c),
    .op_d         (op_d),
    .op_delta     (op_delta),
    .op_e         (op_e),
    .op_erase     (op_erase),
    .op_f         (op_f),
    .op_g         (op_g),
    .op_h         (op_h),
    .op_i         (op_i),
    .op_j         (op_j),
    .op_k         (op_k),
    .op_l         (op_l),
    .op_m         (op_m),
    .op_n         (op_n),
    .op_o         (op_o),
    .op_p         (op_p),
    .op_phi       (op_phi),
    .op_pi        (op_pi),
    .op_q         (op_q),
    .op_r         (op_r),
    .op_s         (op_s),
    .op_t         (op_t),
    .op_theta     (op_theta),
    .op_u         (op_u),
    .op_v         (op_v),
    .op_w         (op_w),
    .op_x         (op_x),
    .op_y         (op_y),
    .op_z         (op_z),
    .starter      (starter),
    .starter_neg  (starter_neg),
    .extended_neg (extended_neg)
    );

  transfer transfer (
    .mib         (mob),

    .mob         (mib),
    .clk         (clk),
    .f1_pos      (f1_pos),
    .f2_pos      (f2_pos), 
    .mob_asu1    (mob_asu1),
    .mob_tape    (mob_tape),
    .mob_starter (mob_starter),
    .mob_printer (mob_printer),
    .f1_mob      (f1_mob),
    .f2_mob      (f2_mob),
    .r1_mob      (r1_mob),
    .r2_mob      (r2_mob)
    );

  timing_ctrl_shift timing_ctrl_shift (
    .seventy_d35 (seventy_d35),
    .da          (da),
    .dx          (dx),
    .dy          (dy),
    .g2_pos      (g2_pos),
    .g2_neg      (g2_neg),

    .clk         (clk),
    .c5          (c5),
    .c6          (c6),
    .zero_d0     (zero_d0),
    .d35         (d35)
    );

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
    .order_sct (order_sct)
    );

/* This is the first stage of Tank decoding to determine rack to be 
 * selected - F1, F2, R1 or R2. Additional control signal determine 
 * access type - read or write.
 */
  tank_decoder0 tank_decoder0 (
    .f1_read     (f1_read),
    .f1_write    (f1_write),
    .f2_read     (f2_read),
    .f2_write    (f2_write),
    .r1_read     (r1_read),
    .r1_write    (r1_write),
    .r2_read     (r2_read),
    .r2_write    (r2_write),

    .c17a        (c17a),
    .f10_pos     (f10_pos),
    .f11_pos     (f11_pos),
    .cu_gate_pos (cu_gate_pos)
   );

  tank_decoder1 tank_decoder1_f1 (
    .rack_down_in     (f1_down_in),
    .rack_up_in       (f1_up_in),
    .rack_down_out    (f1_down_out),
    .rack_up_out      (f1_up_out),
    .rack_down_t0_clr (f1_down_t0_clr),
    .rack_up_t0_clr   (f1_up_t0_clr),
    .rack_down_t1_clr (f1_down_t1_clr),
    .rack_up_t1_clr   (f1_up_t1_clr),
    .rack_down_t2_clr (f1_down_t2_clr),
    .rack_up_t2_clr   (f1_up_t2_clr),
    .rack_down_t3_clr (f1_down_t3_clr),
    .rack_up_t3_clr   (f1_up_t3_clr),
    .rack_mib         (f1_mib),
    .rack_mob         (f1_mob),

    .rack_read        (f1_read),
    .rack_write       (f1_write),
    .f9_pos           (f9_pos),
    .rack_down_mob_t0 (f1_down_mob_t0),
    .rack_up_mob_t0   (f1_up_mob_t0),
    .rack_down_mob_t1 (f1_down_mob_t1),
    .rack_up_mob_t1   (f1_up_mob_t1),
    .rack_down_mob_t2 (f1_down_mob_t2),
    .rack_up_mob_t2   (f1_up_mob_t2),
    .rack_down_mob_t3 (f1_down_mob_t3),
    .rack_up_mob_t3   (f1_up_mob_t3),
    .rack_down_t0_in  (f1_down_t0_in),
    .rack_up_t0_in    (f1_up_t0_in),
    .rack_down_t1_in  (f1_down_t1_in),
    .rack_up_t1_in    (f1_up_t1_in),
    .rack_down_t2_in  (f1_down_t2_in),
    .rack_up_t2_in    (f1_up_t2_in),
    .rack_down_t3_in  (f1_down_t3_in),
    .rack_up_t3_in    (f1_up_t3_in),
    .mib              (mib)
    );

  tank_decoder1 tank_decoder1_f2 (
    .rack_down_in     (f2_down_in),
    .rack_up_in       (f2_up_in),
    .rack_down_out    (f2_down_out),
    .rack_up_out      (f2_up_out),
    .rack_down_t0_clr (f2_down_t0_clr),
    .rack_up_t0_clr   (f2_up_t0_clr),
    .rack_down_t1_clr (f2_down_t1_clr),
    .rack_up_t1_clr   (f2_up_t1_clr),
    .rack_down_t2_clr (f2_down_t2_clr),
    .rack_up_t2_clr   (f2_up_t2_clr),
    .rack_down_t3_clr (f2_down_t3_clr),
    .rack_up_t3_clr   (f2_up_t3_clr),
    .rack_mib         (f2_mib),
    .rack_mob         (f2_mob),

    .rack_read        (f2_read),
    .rack_write       (f2_write),
    .f9_pos           (f9_pos),
    .rack_down_mob_t0 (f2_down_mob_t0),
    .rack_up_mob_t0   (f2_up_mob_t0),
    .rack_down_mob_t1 (f2_down_mob_t1),
    .rack_up_mob_t1   (f2_up_mob_t1),
    .rack_down_mob_t2 (f2_down_mob_t2),
    .rack_up_mob_t2   (f2_up_mob_t2),
    .rack_down_mob_t3 (f2_down_mob_t3),
    .rack_up_mob_t3   (f2_up_mob_t3),
    .rack_down_t0_in  (f2_down_t0_in),
    .rack_up_t0_in    (f2_up_t0_in),
    .rack_down_t1_in  (f2_down_t1_in),
    .rack_up_t1_in    (f2_up_t1_in),
    .rack_down_t2_in  (f2_down_t2_in),
    .rack_up_t2_in    (f2_up_t2_in),
    .rack_down_t3_in  (f2_down_t3_in),
    .rack_up_t3_in    (f2_up_t3_in),
    .mib              (mib)
    );

  tank_decoder1 tank_decoder1_r1 (
    .rack_down_in     (r1_down_in),
    .rack_up_in       (r1_up_in),
    .rack_down_out    (r1_down_out),
    .rack_up_out      (r1_up_out),
    .rack_down_t0_clr (r1_down_t0_clr),
    .rack_up_t0_clr   (r1_up_t0_clr),
    .rack_down_t1_clr (r1_down_t1_clr),
    .rack_up_t1_clr   (r1_up_t1_clr),
    .rack_down_t2_clr (r1_down_t2_clr),
    .rack_up_t2_clr   (r1_up_t2_clr),
    .rack_down_t3_clr (r1_down_t3_clr),
    .rack_up_t3_clr   (r1_up_t3_clr),
    .rack_mib         (r1_mib),
    .rack_mob         (r1_mob),

    .rack_read        (r1_read),
    .rack_write       (r1_write),
    .f9_pos           (f9_pos),
    .rack_down_mob_t0 (r1_down_mob_t0),
    .rack_up_mob_t0   (r1_up_mob_t0),
    .rack_down_mob_t1 (r1_down_mob_t1),
    .rack_up_mob_t1   (r1_up_mob_t1),
    .rack_down_mob_t2 (r1_down_mob_t2),
    .rack_up_mob_t2   (r1_up_mob_t2),
    .rack_down_mob_t3 (r1_down_mob_t3),
    .rack_up_mob_t3   (r1_up_mob_t3),
    .rack_down_t0_in  (r1_down_t0_in),
    .rack_up_t0_in    (r1_up_t0_in),
    .rack_down_t1_in  (r1_down_t1_in),
    .rack_up_t1_in    (r1_up_t1_in),
    .rack_down_t2_in  (r1_down_t2_in),
    .rack_up_t2_in    (r1_up_t2_in),
    .rack_down_t3_in  (r1_down_t3_in),
    .rack_up_t3_in    (r1_up_t3_in),
    .mib              (mib)
    );

  tank_decoder1 tank_decoder1_r2 (
    .rack_down_in     (r2_down_in),
    .rack_up_in       (r2_up_in),
    .rack_down_out    (r2_down_out),
    .rack_up_out      (r2_up_out),
    .rack_down_t0_clr (r2_down_t0_clr),
    .rack_up_t0_clr   (r2_up_t0_clr),
    .rack_down_t1_clr (r2_down_t1_clr),
    .rack_up_t1_clr   (r2_up_t1_clr),
    .rack_down_t2_clr (r2_down_t2_clr),
    .rack_up_t2_clr   (r2_up_t2_clr),
    .rack_down_t3_clr (r2_down_t3_clr),
    .rack_up_t3_clr   (r2_up_t3_clr),
    .rack_mib         (r2_mib),
    .rack_mob         (r2_mob),

    .rack_read        (r2_read),
    .rack_write       (r2_write),
    .f9_pos           (f9_pos),
    .rack_down_mob_t0 (r2_down_mob_t0),
    .rack_up_mob_t0   (r2_up_mob_t0),
    .rack_down_mob_t1 (r2_down_mob_t1),
    .rack_up_mob_t1   (r2_up_mob_t1),
    .rack_down_mob_t2 (r2_down_mob_t2),
    .rack_up_mob_t2   (r2_up_mob_t2),
    .rack_down_mob_t3 (r2_down_mob_t3),
    .rack_up_mob_t3   (r2_up_mob_t3),
    .rack_down_t0_in  (r2_down_t0_in),
    .rack_up_t0_in    (r2_up_t0_in),
    .rack_down_t1_in  (r2_down_t1_in),
    .rack_up_t1_in    (r2_up_t1_in),
    .rack_down_t2_in  (r2_down_t2_in),
    .rack_up_t2_in    (r2_up_t2_in),
    .rack_down_t3_in  (r2_down_t3_in),
    .rack_up_t3_in    (r2_up_t3_in),
    .mib              (mib)
    );

  tank_decoder2 tank_decoder2_f1_down (
    .rack_loc_t0_in  (f1_down_t0_in),
    .rack_loc_t1_in  (f1_down_t1_in),
    .rack_loc_t2_in  (f1_down_t2_in),
    .rack_loc_t3_in  (f1_down_t3_in),
    .rack_loc_t0_out (f1_down_t0_out),
    .rack_loc_t1_out (f1_down_t1_out),
    .rack_loc_t2_out (f1_down_t2_out),
    .rack_loc_t3_out (f1_down_t3_out),

    .rack_loc_f7_pos (f1_down_f7_pos),
    .rack_loc_f7_neg (f1_down_f7_neg),
    .rack_loc_f8_pos (f1_down_f8_pos),
    .rack_loc_f8_neg (f1_down_f8_neg),
    .rack_loc_t_in   (f1_down_t_in),
    .rack_loc_t_out  (f1_down_t_out)
    );

  tank_decoder2 tank_decoder2_f1_up (
    .rack_loc_t0_in  (f1_up_t0_in),
    .rack_loc_t1_in  (f1_up_t1_in),
    .rack_loc_t2_in  (f1_up_t2_in),
    .rack_loc_t3_in  (f1_up_t3_in),
    .rack_loc_t0_out (f1_up_t0_out),
    .rack_loc_t1_out (f1_up_t1_out),
    .rack_loc_t2_out (f1_up_t2_out),
    .rack_loc_t3_out (f1_up_t3_out),

    .rack_loc_f7_pos (f1_up_f7_pos),
    .rack_loc_f7_neg (f1_up_f7_neg),
    .rack_loc_f8_pos (f1_up_f8_pos),
    .rack_loc_f8_neg (f1_up_f8_neg),
    .rack_loc_t_in   (f1_up_t_in),
    .rack_loc_t_out  (f1_up_t_out)
    );

  tank_decoder2 tank_decoder2_f2_down (
    .rack_loc_t0_in  (f2_down_t0_in),
    .rack_loc_t1_in  (f2_down_t1_in),
    .rack_loc_t2_in  (f2_down_t2_in),
    .rack_loc_t3_in  (f2_down_t3_in),
    .rack_loc_t0_out (f2_down_t0_out),
    .rack_loc_t1_out (f2_down_t1_out),
    .rack_loc_t2_out (f2_down_t2_out),
    .rack_loc_t3_out (f2_down_t3_out),

    .rack_loc_f7_pos (f2_down_f7_pos),
    .rack_loc_f7_neg (f2_down_f7_neg),
    .rack_loc_f8_pos (f2_down_f8_pos),
    .rack_loc_f8_neg (f2_down_f8_neg),
    .rack_loc_t_in   (f2_down_t_in),
    .rack_loc_t_out  (f2_down_t_out)
    );

  tank_decoder2 tank_decoder2_f2_up (
    .rack_loc_t0_in  (f2_up_t0_in),
    .rack_loc_t1_in  (f2_up_t1_in),
    .rack_loc_t2_in  (f2_up_t2_in),
    .rack_loc_t3_in  (f2_up_t3_in),
    .rack_loc_t0_out (f2_up_t0_out),
    .rack_loc_t1_out (f2_up_t1_out),
    .rack_loc_t2_out (f2_up_t2_out),
    .rack_loc_t3_out (f2_up_t3_out),

    .rack_loc_f7_pos (f2_up_f7_pos),
    .rack_loc_f7_neg (f2_up_f7_neg),
    .rack_loc_f8_pos (f2_up_f8_pos),
    .rack_loc_f8_neg (f2_up_f8_neg),
    .rack_loc_t_in   (f2_up_t_in),
    .rack_loc_t_out  (f2_up_t_out)
    );

  tank_decoder2 tank_decoder2_r1_down (
    .rack_loc_t0_in  (r1_down_t0_in),
    .rack_loc_t1_in  (r1_down_t1_in),
    .rack_loc_t2_in  (r1_down_t2_in),
    .rack_loc_t3_in  (r1_down_t3_in),
    .rack_loc_t0_out (r1_down_t0_out),
    .rack_loc_t1_out (r1_down_t1_out),
    .rack_loc_t2_out (r1_down_t2_out),
    .rack_loc_t3_out (r1_down_t3_out),

    .rack_loc_f7_pos (r1_down_f7_pos),
    .rack_loc_f7_neg (r1_down_f7_neg),
    .rack_loc_f8_pos (r1_down_f8_pos),
    .rack_loc_f8_neg (r1_down_f8_neg),
    .rack_loc_t_in   (r1_down_t_in),
    .rack_loc_t_out  (r1_down_t_out)
    );

  tank_decoder2 tank_decoder2_r1_up (
    .rack_loc_t0_in  (r1_up_t0_in),
    .rack_loc_t1_in  (r1_up_t1_in),
    .rack_loc_t2_in  (r1_up_t2_in),
    .rack_loc_t3_in  (r1_up_t3_in),
    .rack_loc_t0_out (r1_up_t0_out),
    .rack_loc_t1_out (r1_up_t1_out),
    .rack_loc_t2_out (r1_up_t2_out),
    .rack_loc_t3_out (r1_up_t3_out),

    .rack_loc_f7_pos (r1_up_f7_pos),
    .rack_loc_f7_neg (r1_up_f7_neg),
    .rack_loc_f8_pos (r1_up_f8_pos),
    .rack_loc_f8_neg (r1_up_f8_neg),
    .rack_loc_t_in   (r1_up_t_in),
    .rack_loc_t_out  (r1_up_t_out)
    );

  tank_decoder2 tank_decoder2_r2_down (
    .rack_loc_t0_in  (r2_down_t0_in),
    .rack_loc_t1_in  (r2_down_t1_in),
    .rack_loc_t2_in  (r2_down_t2_in),
    .rack_loc_t3_in  (r2_down_t3_in),
    .rack_loc_t0_out (r2_down_t0_out),
    .rack_loc_t1_out (r2_down_t1_out),
    .rack_loc_t2_out (r2_down_t2_out),
    .rack_loc_t3_out (r2_down_t3_out),

    .rack_loc_f7_pos (r2_down_f7_pos),
    .rack_loc_f7_neg (r2_down_f7_neg),
    .rack_loc_f8_pos (r2_down_f8_pos),
    .rack_loc_f8_neg (r2_down_f8_neg),
    .rack_loc_t_in   (r2_down_t_in),
    .rack_loc_t_out  (r2_down_t_out)
    );

  tank_decoder2 tank_decoder2_r2_up (
    .rack_loc_t0_in  (r2_up_t0_in),
    .rack_loc_t1_in  (r2_up_t1_in),
    .rack_loc_t2_in  (r2_up_t2_in),
    .rack_loc_t3_in  (r2_up_t3_in),
    .rack_loc_t0_out (r2_up_t0_out),
    .rack_loc_t1_out (r2_up_t1_out),
    .rack_loc_t2_out (r2_up_t2_out),
    .rack_loc_t3_out (r2_up_t3_out),

    .rack_loc_f7_pos (r2_up_f7_pos),
    .rack_loc_f7_neg (r2_up_f7_neg),
    .rack_loc_f8_pos (r2_up_f8_pos),
    .rack_loc_f8_neg (r2_up_f8_neg),
    .rack_loc_t_in   (r2_up_t_in),
    .rack_loc_t_out  (r2_up_t_out)
    );

  tank_dist tank_dist_f1 (
    .rack_down_f7_pos (f1_down_f7_pos),
    .rack_up_f7_pos   (f1_up_f7_pos),
    .rack_down_f7_neg (f1_down_f7_neg),
    .rack_up_f7_neg   (f1_up_f7_neg),
    .rack_down_f8_pos (f1_down_f8_pos),
    .rack_up_f8_pos   (f1_up_f8_pos),
    .rack_down_f8_neg (f1_down_f8_neg),
    .rack_up_f8_neg   (f1_up_f8_neg),
    .rack_down_t_in   (f1_down_t_in),
    .rack_up_t_in     (f1_up_t_in),
    .rack_down_t_out  (f1_down_t_out),
    .rack_up_t_out    (f1_up_t_out),

    .rack_down_in     (f1_down_in),
    .rack_down_out    (f1_down_out),
    .rack_up_in       (f1_up_in),
    .rack_up_out      (f1_up_out),
    .f7_pos           (f7_pos),
    .f8_pos           (f8_pos)
    );

  tank_dist tank_dist_f2 (
    .rack_down_f7_pos (f2_down_f7_pos),
    .rack_up_f7_pos   (f2_up_f7_pos),
    .rack_down_f7_neg (f2_down_f7_neg),
    .rack_up_f7_neg   (f2_up_f7_neg),
    .rack_down_f8_pos (f2_down_f8_pos),
    .rack_up_f8_pos   (f2_up_f8_pos),
    .rack_down_f8_neg (f2_down_f8_neg),
    .rack_up_f8_neg   (f2_up_f8_neg),
    .rack_down_t_in   (f2_down_t_in),
    .rack_up_t_in     (f2_up_t_in),
    .rack_down_t_out  (f2_down_t_out),
    .rack_up_t_out    (f2_up_t_out),

    .rack_down_in     (f2_down_in),
    .rack_down_out    (f2_down_out),
    .rack_up_in       (f2_up_in),
    .rack_up_out      (f2_up_out),
    .f7_pos           (f7_pos),
    .f8_pos           (f8_pos)
    );

  tank_dist tank_dist_r1 (
    .rack_down_f7_pos (r1_down_f7_pos),
    .rack_up_f7_pos   (r1_up_f7_pos),
    .rack_down_f7_neg (r1_down_f7_neg),
    .rack_up_f7_neg   (r1_up_f7_neg),
    .rack_down_f8_pos (r1_down_f8_pos),
    .rack_up_f8_pos   (r1_up_f8_pos),
    .rack_down_f8_neg (r1_down_f8_neg),
    .rack_up_f8_neg   (r1_up_f8_neg),
    .rack_down_t_in   (r1_down_t_in),
    .rack_up_t_in     (r1_up_t_in),
    .rack_down_t_out  (r1_down_t_out),
    .rack_up_t_out    (r1_up_t_out),

    .rack_down_in     (r1_down_in),
    .rack_down_out    (r1_down_out),
    .rack_up_in       (r1_up_in),
    .rack_up_out      (r1_up_out),
    .f7_pos           (f7_pos),
    .f8_pos           (f8_pos)
    );

  tank_dist tank_dist_r2 (
    .rack_down_f7_pos (r2_down_f7_pos),
    .rack_up_f7_pos   (r2_up_f7_pos),
    .rack_down_f7_neg (r2_down_f7_neg),
    .rack_up_f7_neg   (r2_up_f7_neg),
    .rack_down_f8_pos (r2_down_f8_pos),
    .rack_up_f8_pos   (r2_up_f8_pos),
    .rack_down_f8_neg (r2_down_f8_neg),
    .rack_up_f8_neg   (r2_up_f8_neg),
    .rack_down_t_in   (r2_down_t_in),
    .rack_up_t_in     (r2_up_t_in),
    .rack_down_t_out  (r2_down_t_out),
    .rack_up_t_out    (r2_up_t_out),

    .rack_down_in     (r2_down_in),
    .rack_down_out    (r2_down_out),
    .rack_up_in       (r2_up_in),
    .rack_up_out      (r2_up_out),
    .f7_pos           (f7_pos),
    .f8_pos           (f8_pos)
    );

  order_flash order_flash (
    .f13_pos         (f13_pos),
    .f13_neg         (f13_neg),
    .f14_pos         (f14_pos),
    .f14_neg         (f14_neg),
    .f15_pos         (f15_pos),
    .f15_neg         (f15_neg),
    .f16_pos         (f16_pos),
    .f16_neg         (f16_neg),
    .f17_pos         (f17_pos),
    .f17_neg         (f17_neg),
    .order_flash_rdy (order_flash_rdy),

    .d31             (d31),
    .d32             (d32),
    .d33             (d33),
    .d34             (d34),
    .d35             (d35),
    .g13             (g13),
    .epsep           (epsep),
    .order           (order)
    );

  counter counter (
    .cntr           (cntr),

    .clk            (clk),
    .d2             (d2),
    .d20            (d20),
    .reset_cntr_neg (reset_cntr_neg)
    );

  coincidence coincidence (
    .cu_gate_pos (cu_gate_pos),
    .cu_gate_neg (cu_gate_neg),
    .order_sct   (order_sct),
    .r_pulse     (r_pulse),

    .clk         (clk),
    .cntr        (cntr),
    .sct         (sct),
    .order       (order),
    .s1          (s1),
    .d2          (d2),
    .d20         (d20),
    .d7          (d7),
    .d25         (d25),
    .d0          (d0),
    .d18         (d18),
    .f1_neg      (f1_neg)
    );

  order_tank order_tank (
    .order        (order),

    .clk          (clk),
    .cu_gate_pos  (cu_gate_pos),
    .g12          (g12),
    .g13          (g13),
    .order_clr    (order_clr),
    .mob          (mob),
    .eng_mode_neg (eng_mode_neg),
    .eng_order    (eng_order),
    .epsep        (epsep),
    .starter_neg  (starter_neg)
    );

  sequence_ctrl_tank sequence_ctrl_tank (
      .sct (sct),

      .clk (clk),
      .g12 (g12),
      .sct_clear_gate (sct_clear_gate),
      .sct_in_gate (sct_in_gate),
      .sct_one (sct_one),
      .order (order),
      .reset_sct_neg (reset_sct_neg)
    );

  main_ctrl main_ctrl (
    .ep_done        (ep_done),
    .g12            (g12),
    .g13            (g13),
    .r2             (r2),
    .s1             (s1),
    .s2             (s2),
    .sct_clear_gate (sct_clear_gate),
    .sct_in_gate    (sct_in_gate),
    .sct_one        (sct_one),

    .clk            (clk),
    .ep             (ep),
    .single_ep      (single_ep),
    .stop_neg       (stop_neg),
    .r_pulse        (r_pulse),
    .d0             (d0),
    .c17            (c17),
    .c21            (c21),
    .c26            (c26),
    .d18            (d18),
    .dv_d           (dv_d),
    .eng_mode_neg   (eng_mode_neg),
    .stop_one_a     (stop_one_a),
    .stop_one_b     (stop_one_b),
    .stop_one_c     (stop_one_c)
    );

endmodule
