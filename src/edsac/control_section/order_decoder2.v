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
 
 /* Order Decoder 2 is the final stage in decoding an order. 
 * There are 4 instances of this top-level module, so 32 possible 
 * outputs. Each of the four instances uses the three least significant 
 * bits of the opcode (the two most significant bits used in the previous 
 * stage of decoding.
 * 
 * TODO: Inverted opcode bit signals are not used in this module, 
 *       but the original machine did make use of it. Remove from port 
 *       list?
 * 
 *  opcode | binary code
 * --------+-------------
 *   P     |    00000
 *   Q     |    00001
 *   W     |    00010
 *   E     |    00011
 *   R     |    00100
 *   T     |    00101
 *   Y     |    00110
 *   U     |    00111
 *   I     |    01000
 *   O     |    01001
 *   J     |    01010
 *   pi    |    01011
 *   S     |    01100
 *   Z     |    01101
 *   K     |    01110
 *   erase |    01111
 *   blank |    10000
 *   F     |    10001
 *   theta |    10010
 *   D     |    10011
 *   phi   |    10100
 *   H     |    10101
 *   N     |    10110
 *   M     |    10111
 *   delta |    11000
 *   L     |    11001
 *   X     |    11010
 *   G     |    11011
 *   A     |    11100
 *   B     |    11101
 *   C     |    11110
 *   V     |    11111
 */

module order_decoder2 (
  output wire op1,
  output wire op2,
  output wire op3,
  output wire op4,
  output wire op5,
  output wire op6,
  output wire op7,
  output wire op8,

  input wire  f13_pos, // Order bit 13 (opcode bit 0), least significant. From Order Flashing Unit.
  input wire  f13_neg,
  input wire  f14_pos, // Order bit 14 (opcode bit 1). From Order Flashing Unit.
  input wire  f14_neg,
  input wire  f15_pos, // Order bit 15 (opcode bit 2). From Order Flashing Unit.
  input wire  f15_neg,
  input wire  o_dy // From Order Decoder 1, selects one of the four Order Decoder 2 Units.
  );

  wire [2:0] count = {f15_pos, f14_pos, f13_pos};
  assign {op8, op7, op6, op5, op4, op3, op2, op1} = o_dy ? (8'b0000_0001 << count[2:0]) : 8'b0000_0000;

endmodule
