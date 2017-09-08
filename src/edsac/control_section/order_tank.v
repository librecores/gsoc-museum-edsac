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
 
 /* Order Tank is short 18 bit 36 us delay line. Holds the current 
 * instruction. Cleared at the end of Stage 2.
 * 
 * TODO: This unit has some discrepancies in terms of input/output 
 *       signals. epsep is mentioned, but not used. Usage of epsep, 
 *       eng_mode_neg, eng_order and starter_neg is unclear.
 *       It seems that eng_oreder was an instrument to manually 
 *       admit orders into the Order Tank using toggle switches 
 *       on the Engineers Control Panel. This was gated by the eng_mode 
 *       toggle.
 * TODO: eng_order or eng_mode_neg logic is NOT implemented here.
 * 
 * Order bits -
 *   0 1 2  3-6  7-11   13-17
 *  --------------------------
 *  | | | |    |     | |     |
 *  --------------------------
 * 0:     Blank (to do with circuit setup time).
 * 1:     Instruction length (short/long).
 * 2:     Half M/C (odd/even).
 * 3-6:   Position within tank. Used by the Coincidence Unit 
 *        to select the requisite number from the 16 that 
 *        are in circulation within a Tank.
 * 7-11:  Tank Number bits. Used by Tank Number Flashing Units 
 *        and Tank Decoders to select and provide route 
 *        to the requisite tank.
 * 12:    Spare bit.
 * 13-17: Opcode bits.
 */

module order_tank (
  output wire order,

  input wire  clk,
  input wire  cu_gate_pos, // Coincidence Gate.
  input wire  g12, // Stage 1 of main control.
  input wire  g13, // Stage 2 of main control.
  input wire  order_clr,
  input wire  mob, // Main Output Bus.
  input wire  eng_mode_neg,
  input wire  eng_order,
  input wire  epsep,
  input wire  starter_neg
  );

  wire data_out;
  wire data_clr;
  wire data_in_gate;

  // TODO: What happens when cu_gate_pos is high but (g12 is low or Stage 2 
  // is in effect)? We definitely need recirculation of order in Order Tank 
  // while in Stage 2.
  assign data_clr     = ~(cu_gate_pos | order_clr);
  assign data_in_gate = cu_gate_pos & g12;

  // 18 bit 36 us Order Tank with recirculation.
  delay_line #(.STORE_LEN(1), .WORD_WIDTH(18)) order_store (
    .monitor      (), // Unconnected.
    .data_out     (data_out),
    .clk          (clk),
    .data_in      (mob),
    .data_in_gate (data_in_gate),
    .data_clr     (data_clr)
    );

  assign order = (starter_neg & g13) ? data_out : 1'b0;

endmodule
