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
 
 /* Sequence Control Tank is what one would call an "Instruction Register" 
 * or "Program Counter" in modern computer architecture terms. This unit 
 * has an 18 bit 36 us delay line along with a half adder to increment 
 * value on receipt of EP.
 * 
 * SCT is in a cleared state before commencing operation.
 * 
 * TODO: Only 10 bits are required to exactly determine the Memory Tank 
 *       harbouring the correct half of the proper minor cycle. But 
 *       it seems that in case of a conditional transfer order, the full 
 *       18 bit order itself enters into the SCT. (Validate?)
 * 
 * TODO: How is the functioning of Starter Unit and SCT related?
 * 
 * TODO: (very important!) Does the half adder in the SCT have a 1 p.i. 
 *       delay that half adders in the machine are usually subject to? 
 *       To answer this, consider the CU. Coincidence is sought only 
 *       within the window d2 to d7 (excluding d7), which means the inputs 
 *       to CU from Counter and SCT must arrive within this window (of course 
 *       the two arriving inputs must also align with each other). SCT increments 
 *       value on receipt of sct_one, which is same as EP for this case, which 
 *       in turn is triggered at ev_d0. Thus, SCT output must arrive 2 p.i. later. 
 *       This is a hypothesis and needs to be validated, but for now the modules 
 *       assume this hypothesis to be true.
 */

module sequence_ctrl_tank (
  output wire sct, // Goes to Coincidence Unit during Stage 1.

  input wire  clk,
  input wire  g12, // Stage 1 of main control.
  input wire  sct_clear_gate, // Active low.
  input wire  sct_in_gate, // In case of conditional transfer orders, admits order into SCT.
  input wire  sct_one, // From MCU, increments value by one.
  input wire  order, // Order from Order Tank when conditional transfer order is to be executed.
  input wire  reset_sct_neg // From Starter Unit. Active low.
  );

  wire sct_store_in;
  wire sct_store_out;
  wire hf_out;
  wire scti;

  assign sct_store_in = (sct_in_gate & order) | (sct_clear_gate & reset_sct_neg & hf_out);

  // 36 us 18 bit SCT delay line.
  delay #(.INTERVAL(18)) sct_store (
    .out (sct_store_out),
    .clk (clk),
    .in  (sct_store_in)
    );

  half_adder hf (
    .sum       (hf_out),
    .del_carry (), // Unconnected.
    .clk       (clk),
    .a         (sct_one),
    .b         (sct_store_out)
    );

  delay #(.INTERVAL(2)) dl_hf (
    .out (scti),
    .clk (clk),
    .in  (hf_out)
    );

  assign sct = g12 ? scti : 1'b0;

endmodule
