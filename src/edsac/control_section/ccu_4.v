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
 
 /* CCU 4 facilitates A, S, C orders. The report says the panel 
 * also deals with muliplication instructions, but it seems 
 * to be limited to generating g6_pos (used for Multiplicand 
 * gating under A, S, C orders).
 * 
 * TODO: The report also mentions use of sign questioning pulse for A-order,
 * (and its corresponding repsonse), but that has not been included 
 * here.
 */

module ccu_4 (
  output wire ep3, // End pulse for addition and subtraction.
  output wire g6_pos, // Used in Multiplicand Tank for gating.

  input wire  clk,
  input wire  c1, // A, S, C, V, N orders (although only A, S, C used).
  input wire  ev_d0,
  input wire  odd_d0,
  input wire  g8, // Inhibits add/subtract logic.
  input wire  r2 // Stimulating pulse received from MCU, indicates completion of loading.
  );

  wire ff1_out;
  wire ff1_set;
  wire ff2_set;
  wire dl_out;

  assign ff1_set = g8 & r2 & c1;

  flipflop ff1 (
    .out     (ff1_out),
    .out_bar (), // Unconnected.
    .set     (ff1_set),
    .reset   (ep3)
    );

  assign ff2_set = odd_d0 & ff1_out;

  flipflop ff2 (
    .out     (g6_pos),
    .out_bar (), // Unconnected.
    .set     (ff2_set),
    .reset   (ep3)
    );

  delay #(.INTERVAL(1)) dl (
    .out (dl_out),
    .clk (clk),
    .in  (g6_pos)
    );

  assign ep3 = ev_d0 & dl_out;

endmodule
