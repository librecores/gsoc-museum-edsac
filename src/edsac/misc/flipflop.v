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
 
 module flipflop (
  output wire out,
  output wire out_bar,

  input wire  set,
  input wire  reset
  );

  reg  outi = 1'b0;

  always @(posedge set or posedge reset) begin
    if (set)
      outi <= 1'b1;
    else
      outi <= 1'b0;
  end

  assign out = outi;
  assign out_bar = ~out;

endmodule
