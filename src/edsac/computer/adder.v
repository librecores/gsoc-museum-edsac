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
 
 /* The original machine's logic reconstruction 
 * indicates presence of an input signal evD1 
 * which is ignored here for now.
 */

module adder (
  output wire sum,

  input wire  clk,
  input wire  a,
  input wire  b
  );

  wire sum0;
  wire sumi;
  wire carry0_d;
  wire carry_d;
  wire c;

  half_adder ha0 (
    .sum       (sum0),
    .del_carry (carry0_d),
    .clk       (clk),
    .a         (a),
    .b         (b)
    );

  half_adder ha1 (
    .sum       (sumi),
    .del_carry (carry_d),
    .clk       (clk),
    .a         (sum0),
    .b         (c)
    );

  assign c = carry0_d | carry_d;

  delay #(.INTERVAL(2)) dl (
    .out (sum),
    .clk (clk),
    .in  (sumi)
    );

endmodule
