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
 
 /* Top-level Tank Decoder Distribution Unit provides gating EMFs 
 * used in final stage of Tank Decoding. Each rack had a Tank 
 * Distribution Unit, so in all 4 instances of following top 
 * level module.
 */

module tank_dist (
  output wire rack_down_f7_pos,
  output wire rack_up_f7_pos,
  output wire rack_down_f7_neg,
  output wire rack_up_f7_neg,
  output wire rack_down_f8_pos,
  output wire rack_up_f8_pos,
  output wire rack_down_f8_neg,
  output wire rack_up_f8_neg,
  output wire rack_down_t_in,
  output wire rack_up_t_in,
  output wire rack_down_t_out,
  output wire rack_up_t_out,

  input wire  rack_down_in,
  input wire  rack_down_out,
  input wire  rack_up_in,
  input wire  rack_up_out,
  input wire  f7_pos, // Tank address bit 7.
  input wire  f8_pos // Tank address bit 8.
  );

  assign {rack_up_f7_pos, rack_down_f7_pos} = {2{f7_pos}};
  assign {rack_up_f7_neg, rack_down_f7_neg} = {2{~f7_pos}};
  assign {rack_up_f8_pos, rack_down_f8_pos} = {2{f8_pos}};
  assign {rack_up_f8_neg, rack_down_f8_neg} = {2{~f8_pos}};

  // Input/output gating signals used in final stage of Tank Decoding.
  assign rack_down_t_in = rack_down_in;
  assign rack_up_t_in = rack_up_in;
  assign rack_down_t_out = rack_down_out;
  assign rack_up_t_out = rack_up_out;

endmodule
