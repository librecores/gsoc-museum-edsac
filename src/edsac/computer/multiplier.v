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
 
 /* Multiplier Tank is 36-bit (72 us) delay line with 
 * recirculation, just like the Multiplicand Tank.
 * 
 * Only four operations carried out -
 *     - loading, under receipt of H-order indicated by c18,
 *     - reading,
 *     - clearing, under receipt of g10_neg from CCU 9 
 *       (done at start of Stage 2?), and
 *     - testing bits, by dx from TCTSU.
 * 
 * Unlike Multiplicand Tank, no provision for shifting.
 * 
 * Reading only occurs on receipt of C-order and output from 
 * Multiplier is gated in Complementer-Collater.
 * 
 * For multiplication orders, V and N, the shifting and consequent 
 * addition of Multiplicand Tank into Accumulator is governed 
 * by dx_m response of Multiplier to dx (questioned by TCTSU and 
 * response tested in CCU 7).
 */

module multiplier (
  output wire mpier,
  output wire dx_m, // Response to digit test pulse (dx), signalled when corresponding bit is 1.
  output wire ep4, // End pulse.

  input wire  clk,
  input wire  c18, // H order, transfer number from memory into Multiplier.
  input wire  mib,
  input wire  g10_neg, // Inverse Multiplier clear gate.
  input wire  dx, // Digit test pulse for Multiplier.
  input wire  d0, // On receipt of r2, next d0 is gated as ep4.
  input wire  r2 // Stimulating pulse received from MCU, indicates completion of loading. 
  );

  wire r2i;
  wire r2o;
  wire ff_out;
  wire ff_res;

  // Loading and reading logic.
  delay_line #(.STORE_LEN(1), .WORD_WIDTH(36)) mpier_store (
    .monitor      (), // Unconnected.
    .data_out     (mpier),
    .clk          (clk),
    .data_in      (mib),
    .data_in_gate (c18),
    .data_clr     (g10_neg)
    );

  // End pulse (ep4) generating logic.
  assign r2i = r2 & c18;
  delay #(.INTERVAL(1)) r2_dl (
    .out (r2o),
    .clk (clk),
    .in  (r2i)
    );
  flipflop ff (
    .out     (ff_out),
    .out_bar (), // Unconnected.
    .set     (r2o),
    .reset   (ff_res)
    );

  assign ep4 = d0 & ff_out;

  delay #(.INTERVAL(1)) ff_res_dl (
    .out (ff_res),
    .clk (clk),
    .in  (ep4)
    );

  // Testing bits.
  assign dx_m = dx & mpier;

endmodule
