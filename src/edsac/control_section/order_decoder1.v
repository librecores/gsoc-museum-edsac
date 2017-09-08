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
 
 /* First-level Order Decoder Unit. Two most significant opcode bits are used 
 * to select one of the four second-level Order Decoder Units. Outputs from 
 * second-level Order Decoder Units are directly routed to Order Coder.
 * 
 * TODO: f16_neg and f17_neg are unused below but the original machine 
 *       made use of it. (Should it be kept around?)
 */

module order_decoder1 (
  output wire o_dy_0,
  output wire o_dy_1,
  output wire o_dy_2,
  output wire o_dy_3,

  input wire f16_pos, // Order bit 16 (opcode bit 3). From Order Flashing Unit.
  input wire f16_neg,
  input wire f17_pos, // Order bit 17 (opcode bit 4), most significant. From Order Flashing Unit.
  input wire f17_neg,
  input wire order_flash_rdy // Indicates Order Flashing flipflops are set.
  );

  wire [1:0] count = {f17_pos, f16_pos};

  assign {o_dy_3, o_dy_2, o_dy_1, o_dy_0} = order_flash_rdy ? (4'b0001 << count[1:0]) : 4'b0000;

endmodule
