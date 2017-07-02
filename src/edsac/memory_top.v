/* Top module for Memory L1 subsystem.
 *
 * The EDSAC had 32 memory tanks, each designed to hold 
 * 16 full words (36 bits, 72 us delay). It took 1.152 ms for 
 * one complete circulation. Thus 512 full words (576 bits) 
 * could be stored in all. Later in EDSAC's lifetime, the capacity 
 * was doubled to 1024 full words.
 * 
 * The 32 tanks are distributed across 4 racks -
 *     - rack F1, 8 tanks = 4 up + 4 down
 *     - rack F2, 8 tanks = 4 up + 4 down
 *     - rack R1, 8 tanks = 4 up + 4 down
 *     - rack R2, 8 tanks = 4 up + 4 down
 */

module memory_top (
  output wire [575:0] monitor1,
  output wire [575:0] monitor2,
  output wire [575:0] monitor3,
  output wire [575:0] monitor4,
  output wire [575:0] monitor5,
  output wire [575:0] monitor6,
  output wire [575:0] monitor7,
  output wire [575:0] monitor8,
  output wire [575:0] monitor9,
  output wire [575:0] monitor10,
  output wire [575:0] monitor11,
  output wire [575:0] monitor12,
  output wire [575:0] monitor13,
  output wire [575:0] monitor14,
  output wire [575:0] monitor15,
  output wire [575:0] monitor16,
  output wire [575:0] monitor17,
  output wire [575:0] monitor18,
  output wire [575:0] monitor19,
  output wire [575:0] monitor20,
  output wire [575:0] monitor21,
  output wire [575:0] monitor22,
  output wire [575:0] monitor23,
  output wire [575:0] monitor24,
  output wire [575:0] monitor25,
  output wire [575:0] monitor26,
  output wire [575:0] monitor27,
  output wire [575:0] monitor28,
  output wire [575:0] monitor29,
  output wire [575:0] monitor30,
  output wire [575:0] monitor31,
  output wire [575:0] monitor32,
  output wire f1_down_mob_t0,
  output wire f1_up_mob_t0,
  output wire f1_down_mob_t1,
  output wire f1_up_mob_t1,
  output wire f1_down_mob_t2,
  output wire f1_up_mob_t2,
  output wire f1_down_mob_t3,
  output wire f1_up_mob_t3,
  output wire f2_down_mob_t0,
  output wire f2_up_mob_t0,
  output wire f2_down_mob_t1,
  output wire f2_up_mob_t1,
  output wire f2_down_mob_t2,
  output wire f2_up_mob_t2,
  output wire f2_down_mob_t3,
  output wire f2_up_mob_t3,
  output wire r1_down_mob_t0,
  output wire r1_up_mob_t0,
  output wire r1_down_mob_t1,
  output wire r1_up_mob_t1,
  output wire r1_down_mob_t2,
  output wire r1_up_mob_t2,
  output wire r1_down_mob_t3,
  output wire r1_up_mob_t3,
  output wire r2_down_mob_t0,
  output wire r2_up_mob_t0,
  output wire r2_down_mob_t1,
  output wire r2_up_mob_t1,
  output wire r2_down_mob_t2,
  output wire r2_up_mob_t2,
  output wire r2_down_mob_t3,
  output wire r2_up_mob_t3,

  input wire  f1_mib,
  input wire  f2_mib,
  input wire  r1_mib,
  input wire  r2_mib,
  input wire  f1_down_t0_clr,
  input wire  f1_up_t0_clr,
  input wire  f1_down_t1_clr,
  input wire  f1_up_t1_clr,
  input wire  f1_down_t2_clr,
  input wire  f1_up_t2_clr,
  input wire  f1_down_t3_clr,
  input wire  f1_up_t3_clr,
  input wire  f2_down_t0_clr,
  input wire  f2_up_t0_clr,
  input wire  f2_down_t1_clr,
  input wire  f2_up_t1_clr,
  input wire  f2_down_t2_clr,
  input wire  f2_up_t2_clr,
  input wire  f2_down_t3_clr,
  input wire  f2_up_t3_clr,
  input wire  r1_down_t0_clr,
  input wire  r1_up_t0_clr,
  input wire  r1_down_t1_clr,
  input wire  r1_up_t1_clr,
  input wire  r1_down_t2_clr,
  input wire  r1_up_t2_clr,
  input wire  r1_down_t3_clr,
  input wire  r1_up_t3_clr,
  input wire  r2_down_t0_clr,
  input wire  r2_up_t0_clr,
  input wire  r2_down_t1_clr,
  input wire  r2_up_t1_clr,
  input wire  r2_down_t2_clr,
  input wire  r2_up_t2_clr,
  input wire  r2_down_t3_clr,
  input wire  r2_up_t3_clr,
  input wire  f1_up_t0_in,
  input wire  f1_up_t1_in,
  input wire  f1_up_t2_in,
  input wire  f1_up_t3_in,
  input wire  f1_down_t0_in,
  input wire  f1_down_t1_in,
  input wire  f1_down_t2_in,
  input wire  f1_down_t3_in,
  input wire  f1_up_t0_out,
  input wire  f1_up_t1_out,
  input wire  f1_up_t2_out,
  input wire  f1_up_t3_out,
  input wire  f1_down_t0_out,
  input wire  f1_down_t1_out,
  input wire  f1_down_t2_out,
  input wire  f1_down_t3_out,
  input wire  f2_up_t0_in,
  input wire  f2_up_t1_in,
  input wire  f2_up_t2_in,
  input wire  f2_up_t3_in,
  input wire  f2_down_t0_in,
  input wire  f2_down_t1_in,
  input wire  f2_down_t2_in,
  input wire  f2_down_t3_in,
  input wire  f2_up_t0_out,
  input wire  f2_up_t1_out,
  input wire  f2_up_t2_out,
  input wire  f2_up_t3_out,
  input wire  f2_down_t0_out,
  input wire  f2_down_t1_out,
  input wire  f2_down_t2_out,
  input wire  f2_down_t3_out,
  input wire  r1_up_t0_in,
  input wire  r1_up_t1_in,
  input wire  r1_up_t2_in,
  input wire  r1_up_t3_in,
  input wire  r1_down_t0_in,
  input wire  r1_down_t1_in,
  input wire  r1_down_t2_in,
  input wire  r1_down_t3_in,
  input wire  r1_up_t0_out,
  input wire  r1_up_t1_out,
  input wire  r1_up_t2_out,
  input wire  r1_up_t3_out,
  input wire  r1_down_t0_out,
  input wire  r1_down_t1_out,
  input wire  r1_down_t2_out,
  input wire  r1_down_t3_out,
  input wire  r2_up_t0_in,
  input wire  r2_up_t1_in,
  input wire  r2_up_t2_in,
  input wire  r2_up_t3_in,
  input wire  r2_down_t0_in,
  input wire  r2_down_t1_in,
  input wire  r2_down_t2_in,
  input wire  r2_down_t3_in,
  input wire  r2_up_t0_out,
  input wire  r2_up_t1_out,
  input wire  r2_up_t2_out,
  input wire  r2_up_t3_out,
  input wire  r2_down_t0_out,
  input wire  r2_down_t1_out,
  input wire  r2_down_t2_out,
  input wire  r2_down_t3_out,
  input wire  clk
  );

  memory f1_up_t0 (
    .monitor (monitor1),
    .mob_tn  (f1_up_mob_t0),

    .clk     (clk),
    .mib     (f1_mib),
    .tn_in   (f1_up_t0_in),
    .tn_clr  (f1_up_t0_clr),
    .tn_out  (f1_up_t0_out)
    );

  memory f1_up_t1 (
    .monitor (monitor2),
    .mob_tn  (f1_up_mob_t1),

    .clk     (clk),
    .mib     (f1_mib),
    .tn_in   (f1_up_t1_in),
    .tn_clr  (f1_up_t1_clr),
    .tn_out  (f1_up_t1_out)
    );

  memory f1_up_t2 (
    .monitor (monitor3),
    .mob_tn  (f1_up_mob_t2),

    .clk     (clk),
    .mib     (f1_mib),
    .tn_in   (f1_up_t2_in),
    .tn_clr  (f1_up_t2_clr),
    .tn_out  (f1_up_t2_out)
    );

  memory f1_up_t3 (
    .monitor (monitor4),
    .mob_tn  (f1_up_mob_t3),

    .clk     (clk),
    .mib     (f1_mib),
    .tn_in   (f1_up_t3_in),
    .tn_clr  (f1_up_t3_clr),
    .tn_out  (f1_up_t3_out)
    );

  memory f1_down_t0 (
    .monitor (monitor5),
    .mob_tn  (f1_down_mob_t0),

    .clk     (clk),
    .mib     (f1_mib),
    .tn_in   (f1_down_t0_in),
    .tn_clr  (f1_down_t0_clr),
    .tn_out  (f1_down_t0_out)
    );

  memory f1_down_t1 (
    .monitor (monitor6),
    .mob_tn  (f1_down_mob_t1),

    .clk     (clk),
    .mib     (f1_mib),
    .tn_in   (f1_down_t1_in),
    .tn_clr  (f1_down_t1_clr),
    .tn_out  (f1_down_t1_out)
    );

  memory f1_down_t2 (
    .monitor (monitor7),
    .mob_tn  (f1_down_mob_t2),

    .clk     (clk),
    .mib     (f1_mib),
    .tn_in   (f1_down_t2_in),
    .tn_clr  (f1_down_t2_clr),
    .tn_out  (f1_down_t2_out)
    );

  memory f1_down_t3 (
    .monitor (monitor8),
    .mob_tn  (f1_down_mob_t3),

    .clk     (clk),
    .mib     (f1_mib),
    .tn_in   (f1_down_t3_in),
    .tn_clr  (f1_down_t3_clr),
    .tn_out  (f1_down_t3_out)
    );

  memory f2_up_t0 (
    .monitor (monitor9),
    .mob_tn  (f2_up_mob_t0),

    .clk     (clk),
    .mib     (f2_mib),
    .tn_in   (f2_up_t0_in),
    .tn_clr  (f2_up_t0_clr),
    .tn_out  (f2_up_t0_out)
    );

  memory f2_up_t1 (
    .monitor (monitor10),
    .mob_tn  (f2_up_mob_t1),

    .clk     (clk),
    .mib     (f2_mib),
    .tn_in   (f2_up_t1_in),
    .tn_clr  (f2_up_t1_clr),
    .tn_out  (f2_up_t1_out)
    );

  memory f2_up_t2 (
    .monitor (monitor11),
    .mob_tn  (f2_up_mob_t2),

    .clk     (clk),
    .mib     (f2_mib),
    .tn_in   (f2_up_t2_in),
    .tn_clr  (f2_up_t2_clr),
    .tn_out  (f2_up_t2_out)
    );

  memory f2_up_t3 (
    .monitor (monitor12),
    .mob_tn  (f2_up_mob_t3),

    .clk     (clk),
    .mib     (f2_mib),
    .tn_in   (f2_up_t3_in),
    .tn_clr  (f2_up_t3_clr),
    .tn_out  (f2_up_t3_out)
    );

  memory f2_down_t0 (
    .monitor (monitor13),
    .mob_tn  (f2_down_mob_t0),

    .clk     (clk),
    .mib     (f2_mib),
    .tn_in   (f2_down_t0_in),
    .tn_clr  (f2_down_t0_clr),
    .tn_out  (f2_down_t0_out)
    );

  memory f2_down_t1 (
    .monitor (monitor14),
    .mob_tn  (f2_down_mob_t1),

    .clk     (clk),
    .mib     (f2_mib),
    .tn_in   (f2_down_t1_in),
    .tn_clr  (f2_down_t1_clr),
    .tn_out  (f2_down_t1_out)
    );

  memory f2_down_t2 (
    .monitor (monitor15),
    .mob_tn  (f2_down_mob_t2),

    .clk     (clk),
    .mib     (f2_mib),
    .tn_in   (f2_down_t2_in),
    .tn_clr  (f2_down_t2_clr),
    .tn_out  (f2_down_t2_out)
    );

  memory f2_down_t3 (
    .monitor (monitor16),
    .mob_tn  (f2_down_mob_t3),

    .clk     (clk),
    .mib     (f2_mib),
    .tn_in   (f2_down_t3_in),
    .tn_clr  (f2_down_t3_clr),
    .tn_out  (f2_down_t3_out)
    );

  memory r1_up_t0 (
    .monitor (monitor17),
    .mob_tn  (r1_up_mob_t0),

    .clk     (clk),
    .mib     (r1_mib),
    .tn_in   (r1_up_t0_in),
    .tn_clr  (r1_up_t0_clr),
    .tn_out  (r1_up_t0_out)
    );

  memory r1_up_t1 (
    .monitor (monitor18),
    .mob_tn  (r1_up_mob_t1),

    .clk     (clk),
    .mib     (r1_mib),
    .tn_in   (r1_up_t1_in),
    .tn_clr  (r1_up_t1_clr),
    .tn_out  (r1_up_t1_out)
    );

  memory r1_up_t2 (
    .monitor (monitor19),
    .mob_tn  (r1_up_mob_t2),

    .clk     (clk),
    .mib     (r1_mib),
    .tn_in   (r1_up_t2_in),
    .tn_clr  (r1_up_t2_clr),
    .tn_out  (r1_up_t2_out)
    );

  memory r1_up_t3 (
    .monitor (monitor20),
    .mob_tn  (r1_up_mob_t3),

    .clk     (clk),
    .mib     (r1_mib),
    .tn_in   (r1_up_t3_in),
    .tn_clr  (r1_up_t3_clr),
    .tn_out  (r1_up_t3_out)
    );

  memory r1_down_t0 (
    .monitor (monitor21),
    .mob_tn  (r1_down_mob_t0),

    .clk     (clk),
    .mib     (r1_mib),
    .tn_in   (r1_down_t0_in),
    .tn_clr  (r1_down_t0_clr),
    .tn_out  (r1_down_t0_out)
    );

  memory r1_down_t1 (
    .monitor (monitor22),
    .mob_tn  (r1_down_mob_t1),

    .clk     (clk),
    .mib     (r1_mib),
    .tn_in   (r1_down_t1_in),
    .tn_clr  (r1_down_t1_clr),
    .tn_out  (r1_down_t1_out)
    );

  memory r1_down_t2 (
    .monitor (monitor23),
    .mob_tn  (r1_down_mob_t2),

    .clk     (clk),
    .mib     (r1_mib),
    .tn_in   (r1_down_t2_in),
    .tn_clr  (r1_down_t2_clr),
    .tn_out  (r1_down_t2_out)
    );

  memory r1_down_t3 (
    .monitor (monitor24),
    .mob_tn  (r1_down_mob_t3),

    .clk     (clk),
    .mib     (r1_mib),
    .tn_in   (r1_down_t3_in),
    .tn_clr  (r1_down_t3_clr),
    .tn_out  (r1_down_t3_out)
    );

  memory r2_up_t0 (
    .monitor (monitor25),
    .mob_tn  (r2_up_mob_t0),

    .clk     (clk),
    .mib     (r2_mib),
    .tn_in   (r2_up_t0_in),
    .tn_clr  (r2_up_t0_clr),
    .tn_out  (r2_up_t0_out)
    );

  memory r2_up_t1 (
    .monitor (monitor26),
    .mob_tn  (r2_up_mob_t1),

    .clk     (clk),
    .mib     (r2_mib),
    .tn_in   (r2_up_t1_in),
    .tn_clr  (r2_up_t1_clr),
    .tn_out  (r2_up_t1_out)
    );

  memory r2_up_t2 (
    .monitor (monitor27),
    .mob_tn  (r2_up_mob_t2),

    .clk     (clk),
    .mib     (r2_mib),
    .tn_in   (r2_up_t2_in),
    .tn_clr  (r2_up_t2_clr),
    .tn_out  (r2_up_t2_out)
    );

  memory r2_up_t3 (
    .monitor (monitor28),
    .mob_tn  (r2_up_mob_t3),

    .clk     (clk),
    .mib     (r2_mib),
    .tn_in   (r2_up_t3_in),
    .tn_clr  (r2_up_t3_clr),
    .tn_out  (r2_up_t3_out)
    );

  memory r2_down_t0 (
    .monitor (monitor29),
    .mob_tn  (r2_down_mob_t0),

    .clk     (clk),
    .mib     (r2_mib),
    .tn_in   (r2_down_t0_in),
    .tn_clr  (r2_down_t0_clr),
    .tn_out  (r2_down_t0_out)
    );

  memory r2_down_t1 (
    .monitor (monitor30),
    .mob_tn  (r2_down_mob_t1),

    .clk     (clk),
    .mib     (r2_mib),
    .tn_in   (r2_down_t1_in),
    .tn_clr  (r2_down_t1_clr),
    .tn_out  (r2_down_t1_out)
    );

  memory r2_down_t2 (
    .monitor (monitor31),
    .mob_tn  (r2_down_mob_t2),

    .clk     (clk),
    .mib     (r2_mib),
    .tn_in   (r2_down_t2_in),
    .tn_clr  (r2_down_t2_clr),
    .tn_out  (r2_down_t2_out)
    );

  memory r2_down_t3 (
    .monitor (monitor32),
    .mob_tn  (r2_down_mob_t3),

    .clk     (clk),
    .mib     (r2_mib),
    .tn_in   (r2_down_t3_in),
    .tn_clr  (r2_down_t3_clr),
    .tn_out  (r2_down_t3_out)
    );

endmodule
