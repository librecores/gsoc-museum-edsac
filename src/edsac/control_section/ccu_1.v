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
 
 /* CCU 1 is essentially a timing pulse generator.
 * Since Accumulator is double length, minor cycles 
 * are designated odd or even. Arithmetic operations 
 * begin on even cycles.
 */

module ccu_1 (
  output wire g1_pos, // Indicates odd cycle.
  output wire g1_neg, // Indicates even cycle.
  output wire odd_d0,
  output wire odd_d35,
  output wire ev_d0,
  output wire ev_d1,
  output wire ev_d1_dz, // Used in Complementer/Collater when inserting trailing ones in a negated number

  input wire  clk,
  input wire  d0,
  input wire  d1,
  input wire  d18,
  input wire  d35,
  input wire  da_n, // Result of test Multiplicand sign.
  input wire  dy // Resetting pulse after addition of partial product.
  );

  wire odd;
  wire even;
  wire dl_pos_out;
  wire dl_neg_out;
  wire dl_da_n;

  flipflop ff (
    .out     (g1_pos),
    .out_bar (g1_neg),
    .set     (odd),
    .reset   (even)
    );
  delay #(.INTERVAL(1)) dl_pos (
    .out (dl_pos_out),
    .clk (clk),
    .in  (g1_pos)
    );
  delay #(.INTERVAL(1)) dl_neg (
    .out (dl_neg_out),
    .clk (clk),
    .in  (g1_neg)
    );

  wire dl_da_dn;

  assign even = dl_pos_out & d0;
  assign odd  = dl_neg_out & d0;

  assign ev_d0   = g1_neg & d0;
  assign ev_d1   = g1_neg & d1;
  assign odd_d0  = g1_pos & d0;
  assign odd_d35 = g1_pos & d35;

  // ev_d1_dz logic.
  // TODO: This is unclear.
  delay #(.INTERVAL(1)) dl_evd1dz (
    .out (dl_da_dn),
    .clk (clk),
    .in  (da_n)
    );
  assign ev_d1_dz = (dl_da_dn & dy) | g1_neg;

endmodule
