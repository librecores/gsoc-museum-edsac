/* CCU 2 facilitates multiplication and shifting operations.
 *
 * TODO: The original report says zero_d0 is delayed by 1 M/C - 1 p.i. before 
 *       it gates d35. The length of delay is unclear and its impact 
 *       is not understood. Logic diagrams say it could be avoided if flipflop's 
 *       output is taken.
 */

module ccu_2 (
  output wire zero_d0,
  output wire g8,
  output wire da_m,
  output wire ds,

  input wire  c7,
  input wire  d35,
  input wire  da,
  input wire  ev_d0,
  input wire  mcand_in,
  input wire  c5,
  input wire  c6,
  input wire  s2
  );

  wire stim;
  wire ff_set;
  wire ff_out;
  wire ff_reset;
  wire dl_zd0_out;

  assign ds = c7 & zero_d0;

  assign da_m = c5 & da;

  assign stim = (mcand_in & c5) | (c6 & s2);

  delay #(.INTERVAL(1)) dl (
    .out (ff_set),
    .clk (clk),
    .in  (stim)
   );

  flipflop ff (
    .out     (ff_out),
    .out_bar (g8),
    .set     (ff_set),
    .reset   (ff_reset)
    );

  assign zero_d0 = ff_out & ev_d0;

  // Delay of 1 M/C - 1 p.i. = 36 - 1 p.i. = 35 p.i.
  delay #(.INTERVAL(35)) dl_zero_d0 (
    .out (dl_zd0_out),
    .clk (clk),
    .in  (zero_d0)
    );

  assign ff_reset = dl_zd0_out & d35;

endmodule
