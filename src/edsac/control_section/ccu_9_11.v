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
 
 /* CCU 9 and 11 are responsible for generating gating EMFs that 
 * clear tanks - Multiplicand, Accumulator and Multiplier.
 * 
 * TODO: Original report says that the two flipflops (refer code below) 
 *       are reset by next ev_d0, but logic diagram uses ev_d1.
 * 
 * TODO: There is a slight delay before feeding odd_d0 into the gate 
 *       that sets ff_clr (refer code below). This seems to be mostly 
 *       unnecessary here, but need to validate.
 */
module ccu_9_11 (
  output wire ep6, // End Pulse for store and clear.
  output wire ep7, // End Pulse for store and retain.
  output wire g9_neg, // Accumulator clear gate.
  output wire g10_neg, // Multiplier clear gate.
  output wire g11_neg, // Multiplicand clear gate.

  input wire  c18, // H order - transfer from memory to Multiplier.
  input wire  c19, // T, U orders - transfer from Accumulator to memory 
                  // position with/without (T/U) clearing.
  input wire  c20, // T order - transfer from Accumulator to memory and clear.
  input wire  ev_d0,
  input wire  odd_d0,
  input wire  r2, // Coincidence detected to Computer, from MCU.
  input wire  s2, // Stimulating pulse to Computer.
  input wire  op_u, // U order, transfer from Accumulator without clearing.
  input wire  clk
  );

  wire ff_ep7_set;
  wire ff_ep7_out;
  wire ff_clr_set;
  wire ff_clr_out;
  wire g9neg_del;
  wire opu_del;
  wire fep7o_del;
  wire ff_ep7_reset;

  assign ff_ep7_set = (r2 & c19) | (s2 & c18);

  flipflop ff_ep7 (
    .out     (ff_ep7_out),
    .out_bar (), // Unconnected.
    .set     (ff_ep7_set),
    .reset   (ff_ep7_reset)
    );

  assign ff_ep7_reset = ev_d0 & ff_clr_out;
  assign ff_clr_set = odd_d0 & ff_ep7_out;

  flipflop ff_clr (
    .out     (ff_clr_out),
    .out_bar (g11_neg),
    .set     (ff_clr_set),
    .reset   (ev_d0)
    );

  assign g9_neg  = ~(ff_clr_out & c20);
  assign g10_neg = ~(ff_clr_out & c18);

  delay #(.INTERVAL(1)) dl_opu (
    .out (opu_del),
    .clk (clk),
    .in  (op_u)
    );

  delay #(.INTERVAL(1)) dl_g9 (
    .out (g9neg_del),
    .clk (clk),
    .in  (g9_neg)
    );

  delay #(.INTERVAL(1)) dp_ff_ep7 (
    .out (fep7o_del),
    .clk (clk),
    .in  (ff_ep7_out)
    );

  assign ep6 = ev_d0 & ~g9_neg;
  assign ep7 = ev_d0 & opu_del & fep7o_del;

endmodule
