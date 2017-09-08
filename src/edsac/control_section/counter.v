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
 
 /* Counter
 * 
 * Keeps track of half minor cycles in a Memory Tank.
 */

module counter (
  output wire cntr,

  input wire  clk,
  input wire  d2,
  input wire  d20,
  input wire  reset_cntr_neg // From Starter Unit. Active low.
  );

  wire cntr_store_out;
  wire cntr_store_in;
  wire increment;
  wire hf_out;

  assign increment     = d2 | d20;
  assign cntr_store_in = hf_out & reset_cntr_neg;

  // 36 us 18 bit delay line.
  delay #(.INTERVAL(18)) cntr_store (
    .out (cntr_store_out),
    .clk (clk),
    .in  (cntr_store_in)
    );

  half_adder hf (
    .sum       (hf_out),
    .del_carry (), // Unconnected.
    .clk       (clk),
    .a         (cntr_store_out),
    .b         (increment)
    );

  delay #(.INTERVAL(1)) cntr_dl (
    .out (cntr),
    .clk (clk),
    .in  (cntr_store_in)
    );

endmodule
