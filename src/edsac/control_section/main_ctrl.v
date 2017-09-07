/* TODO: There is a very small RC delay (0.08 us) just before a reversed EP resets 
         a flipflop that _should_ permit an EP to pass to SCT as sct_one to increment 
         SCT. Was this necessary? General behaviour of incrementing SCT not 
         understood clearly yet.
 */

module main_ctrl (
  output wire ep_done,
  output wire g12, // Indicates Stage 1 of main control in progress.
  output wire g13, // Indicates Stage 2 of main control in progress.
  output wire r2, // Coincidence detected, to Computer (CCU 4, CCU 9, Multiplier).
  output wire s1,
  output wire s2,
  output wire sct_clear_gate,
  output wire sct_in_gate,
  output wire sct_one,

  input wire  clk,
  input wire  ep, // Combined End Pulse coming from CCU 6.
  input wire  single_ep,
  input wire  stop_neg,
  input wire  r_pulse,
  input wire  d0,
  input wire  c17,
  input wire  c21,
  input wire  c26,
  input wire  d18,
  input wire  dv_d,
  input wire  eng_mode_neg,
  input wire  stop_one_a,
  input wire  stop_one_b,
  input wire  stop_one_c
  );

  wire stop_one; // Combined stop_one_a, stop_one_b, stop_one_c.
  wire s1_gate;
  wire sct_reset_gate; // Gates a d18 (after 1 p.i. delay)  to reset ff_sct in in case of CTO.
  wire dl_sctigr_out;
  wire ff_s1_out;
  wire ff_s1_reset;
  wire dl_fs_out;
  wire g12_del; // g12 delayed by 1 p.i.
  wire g12_set;
  wire g13_reset;
  wire g13_del; // g13 delayed by 1 p.i.
  wire handoff; // Resets g12 and sets g13, causes instant switch from Stage 1 to Stage 2.
  wire ff_s1_set;
  wire ff_sctone_out;


  assign g12_set = (stop_neg & ep) | single_ep;

  flipflop ff_g12 (
    .out     (g12),
    .out_bar (), // Unconnected.
    .set     (g12_set),
    .reset   (handoff)
    );

  delay #(.INTERVAL(1)) dl_g12 (
    .out (g12_del),
    .clk (clk),
    .in  (g12)
    );

  assign handoff = g12_del & r_pulse;

  flipflop ff_g13 (
    .out     (g13),
    .out_bar (), // Unconnected.
    .set     (handoff),
    .reset   (g13_reset)
    );

  assign g13_reset = ep | single_ep;

  delay #(.INTERVAL(1)) dl_g13 (
    .out (g13_del),
    .clk (clk),
    .in  (g13)
    );

  assign s2 = ff_s1_reset & g13;

  assign r2 = g13_del & r_pulse;

  flipflop ff_sct (
    .out     (sct_in_gate),
    .out_bar (sct_clear_gate),
    .set     (dv_d),
    .reset   (1'bx)				// Unused
    );

  delay #(.INTERVAL(1)) dl_sctig_reset (
    .out (sct_reset_gate),
    .clk (clk),
    .in  (sct_in_gate)
    );

/* -----\/----- EXCLUDED -----\/-----
  assign ff_sct_reset = sct_reset_gate & d18;
 -----/\----- EXCLUDED -----/\----- */

  assign stop_one = stop_one_a | stop_one_b | stop_one_c;

  assign ep_done = ~ep; // Logic diagrams show a very small RC delay just after reversing.

  flipflop ff_sctone (
  .out     (), // Unconnected.
    .out_bar (ff_sctone_out),
    .set     (stop_one),
    .reset   (ep_done)
    );

  assign sct_one = ep & ff_sctone_out & eng_mode_neg;

  assign ff_s1_set = handoff | g12_set;

  flipflop ff_s1 (
    .out     (ff_s1_out),
    .out_bar (), // Unconnected.
    .set     (ff_s1_set),
    .reset   (ff_s1_reset)
    );

  delay #(.INTERVAL(1)) dl_ff_s1 (
    .out (dl_fs_out),
    .clk (clk),
    .in  (ff_s1_out)
    );

  assign ff_s1_reset = dl_fs_out & d0;

  assign s1_gate = g12 | c26 | c21 | c17;
  assign s1 = s1_gate & ff_s1_reset;

endmodule
