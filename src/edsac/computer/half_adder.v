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
 
 module half_adder (
  output wire sum,
  output wire del_carry,

  input wire  clk,
  input wire  a,
  input wire  b
  );

  wire carry;

  delay #(.INTERVAL(1)) del (
    .out (del_carry),

    .clk (clk),
    .in  (carry)
    );

  assign sum   = a ^ b;
  assign carry = a & b;

endmodule
