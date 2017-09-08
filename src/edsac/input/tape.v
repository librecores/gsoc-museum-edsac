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
 
 /* Module for Tape Reader Unit.
 */

module tape (
  output wire rdr_busy,
  output wire ep8,
  output wire mob_tape,
  output wire stop_one_a,

  input wire  ep_done,
  input wire  r2,
  input wire  s2,
  input wire  c16,
  input wire  d18,
  input wire  d19,
  input wire  d20,
  input wire  d21,
  input wire  d22
  );

endmodule
