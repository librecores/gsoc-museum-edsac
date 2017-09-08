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
 
 /* Module for Starter Unit/Initial Orders Loader.
 */

module starter (
  output wire boot_valid,
  output wire ep9,
  output wire reset_cntr_neg,
  output wire reset_sct_neg,
  output wire mob_starter,
  output wire sep2,
  output wire starter,
  output wire starter_neg,
  output wire stop_one_d,

  input wire  initial_orders, // Serial input of initial orders.
  input wire  s2,
  input wire  start,
  input wire  d17,
  input wire  d18,
  input wire  d19,
  input wire  d20,
  input wire  d21,
  input wire  d22,
  input wire  d23,
  input wire  d24,
  input wire  d25,
  input wire  d26,
  input wire  d27,
  input wire  d28,
  input wire  d29,
  input wire  d30,
  input wire  d31,
  input wire  d32,
  input wire  d33,
  input wire  d34,
  input wire  d35
  );

endmodule
