/* Copyright 2017 Hatim Kanchwala
 *
 * Contributor Hatim Kanchwala <hatim@hatimak.me>
 *
 * This file is licensed under the CERN OHL v. 1.2. You may redistribute and 
 * modify this documentation under the terms of the 
 * CERN OHL v.1.2. (http://ohwr.org/cernohl). This documentation is distributed 
 * WITHOUT ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING OF MERCHANTABILITY, 
 * SATISFACTORY QUALITY AND FITNESS FOR A PARTICULAR PURPOSE. Please see the 
 * CERN OHL v.1.2 for applicable conditions.
 */
 
 /* CCU 3 is involved in shifting.
 *
 * Shifting in EDSAC was carried out in a very different way then as compared 
 * to todays implementations. The number of bits by which to shift a number, 
 * depended on the position of the least significant bit in the order pulse 
 * train (O1 to O10). Shifting occurs only one digit at a time.
 * 
 * TODO: Timing analysis.
 */

module ccu_3 (
  output wire ep2, // Terminates shifts.
  output wire g5, // Accumulator shifting gate.
  output wire reset_shift_ff, // Resets a flipflop in CCU 8.

  input wire clk,
  input wire zero_d0,
  input wire c6, // R, L shift orders.
  input wire dy, // Resetting pulse after addition of partial product.
  input wire ev_d0,
  input wire ev_d1,
  input wire order // TODO: Ungated order?
  );

  wire ff_ep_out;
  wire ff_ep_set;
  wire ff_ep_reset;
  wire dl_zd0_in;
  wire dl_zd0_out;
  wire ff_g5_set;

  assign dl_zd0_in = c6 & zero_d0;

  // zero_D0 delayed by 1 p.i. to match with an ev_d1.
  delay #(.INTERVAL(1)) dl_zd0 (
    .out (dl_zd0_out),
    .clk (clk),
    .in  (dl_zd0_in)
    );

  assign ff_g5_set = ev_d1 & dl_zd0_out;

  flipflop ff_g5 (
    .out     (g5),
    .out_bar (), // Unconnected.
    .set     (ff_g5_set),
    .reset   (reset_shift_ff)
    );

  // Carry on shifting until coincidence is reached 
  // between order position and dy pulse.
  assign ff_ep_set = order & c6 & dy;

  flipflop ff_ep (
    .out     (ff_ep_out),
    .out_bar (), // Unconnected.
    .set     (ff_ep_set),
    .reset   (ff_ep_reset)
    );

  delay #(.INTERVAL(1)) dl_reset (
    .out (ff_ep_reset),
    .clk (clk),
    .in  (reset_shift_ff)
    );

  assign reset_shift_ff = ev_d1 & ff_ep_out;
  assign ep2 = ev_d0 & ff_ep_out;

endmodule
