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
 
 /* Module for Printer Unit.
 *
 * TODO: Original Logic diagram shows a monitoring input 
         from Multiplicand, but since its purpose is not 
         understood it is not included here.
 */

module printer (
  output wire prt_busy,
  output wire ep10,
  output wire mob_printer,
  output wire stop_one_c,

  input wire  ep_done,
  input wire  r2,
  input wire  c21,
  input wire  d0,
  input wire  d30,
  input wire  d31,
  input wire  d32,
  input wire  d33,
  input wire  d34,
  input wire  d35,
  input wire  op_f
  );

endmodule
