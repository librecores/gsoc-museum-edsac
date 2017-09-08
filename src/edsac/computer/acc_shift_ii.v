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
 
 module acc_shift_ii (
  output wire      adder_a,

  input wire       clk,
  input wire       acc1,
  input wire [3:0] x // Gating EMFs from ASU I. x[0] corresponds to x1 of original logic, x[1] to x2 and so on.
  );

  wire in_dl1;
  wire in_dl2;
  wire in_dl3;
  wire out_dl1;
  wire out_dl2;
  wire out_dl3;
  wire or1;

  delay #(.INTERVAL(1)) d1 (
    .out (out_dl1),
    .clk (clk),
    .in  (in_dl1)
    );

  delay #(.INTERVAL(1)) d2 (
    .out (out_dl2),
    .clk (clk),
    .in  (in_dl2)
    );

  delay #(.INTERVAL(1)) d3 (
    .out (out_dl3),
    .clk (clk),
    .in  (in_dl3)
    );

  assign in_dl1  = acc1 & x[1];
  assign or1     = (x[0] & acc1) | (out_dl1 & clk);
  assign in_dl2  = x[3] & or1;
  assign in_dl3  = (x[2] & or1) | (out_dl2 & clk);
  assign adder_a = out_dl3 & clk;

endmodule
