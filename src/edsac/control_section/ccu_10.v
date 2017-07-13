/* CCU 10 is concerned with handling jump instructions.
 * 
 * TODO: Original report had separate bits of logic 
 *       to handle two conditional jumps. Logic diagram 
 *       shows modifications to it to handle both instructions 
 *       by modifying Accumulator logic. Need to verify the 
 *       modified designed for correctness. The logic diagram's 
 *       version is implemented below.
 */

module ccu_10 (
  output wire dv, // Sign test pulse for E order (jump if Acc >= 0), output to Accumulator.
  output wire ep5, // End Pulse for transfers.
  output wire jump_uc,
  output wire stop_one_b, // Suppress SCT increment during transfers.

  input wire  c10, // G order.
  input wire  c25, // E order.
  input wire  odd_d35,
  input wire  dv_d, // Response to dv pulse sent by CCU 10 to Accumulator.
  input wire  ep_done,
  input wire  ev_d0,
  input wire  extended_pos, // TODO: Use of extended_pos NOT clear.
  input wire  odd_d0,
  input wire  op_j,
  input wire  s2 // Stimulating pulse to Computer from MCU.
  );

  wire fdv_out;
  wire fdv_set;
  wire fdv_reset;
  wire fep5_set;
  wire fep5_out;

  assign jump_uc = extended_pos & op_j;

  assign fdv_set = s2 & (c25 | c10 | jump_uc);

  flipflop ff_dv (
    .out     (fdv_out),
    .out_bar (), // Unconnected.
    .set     (fdv_set),
    .reset   (fdv_reset)
    );

  assign dv = fdv_out & odd_d35;

  assign stop_one_b = fdv_out & dv_d;

  delay #(.INTERVAL(1)) dl (
    .out (fdv_reset),
    .clk (clk),
    .in  (dv)
    );

  assign fep5_set = fdv_out & ev_d0;

  flipflop ff_ep5 (
    .out     (fep5_out),
    .out_bar (), // Unconnected.
    .set     (fep5_set),
    .reset   (ep_done)
    );

  assign ep5 = fep5_out & odd_d0;

endmodule
