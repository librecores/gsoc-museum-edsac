/* The original machine's initial version had 32 Memory Tanks, 
 * distributed over four racks (8 Tanks per rack). Each Tank was
 * capable of holding 16 full words of 36 bits length 72 us delay. 
 * 
 * This is the first stage of Tank decoding. Uses two most significant 
 * bits of the Tank Number field (bits 10 and 11, corresponding to 
 * f10_pos and f11_pos respectively) to determine rack to be 
 * selected - F1, F2, R1 or R2. Additional control signal, c17a gated 
 * with cu_gate_pos, determines access type - read or write.
 */

module tank_decoder0 (
  output wire f1_read,
  output wire f1_write,
  output wire f2_read,
  output wire f2_write,
  output wire r1_read,
  output wire r1_write,
  output wire r2_read,
  output wire r2_write,

  input wire  c17a, // F, I, T, U, Starter order.
  input wire  f10_pos, // Tank address bit 10.
  input wire  f11_pos, // Tank address bit 11.
  input wire  cu_gate_pos // Coincidence gate.
  );

  /*  c17a  f11_pos  f10_pos  |
  * -------------------------+----------------------
  *  0       0        0      | f1_read  (0000_0001)
  *  0       0        1      | f2_read  (0000_0010)
  *  0       1        0      | r1_read  (0000_0100)
  *  0       1        1      | r2_read  (0000_1000)
  *  1       0        0      | f1_write (0001_0000)
  *  1       0        1      | f2_write (0010_0000)
  *  1       1        0      | r1_write (0100_0000)
  *  1       1        1      | r2_write (1000_0000)
  */
  assign {r2_write, r1_write, f2_write, f1_write, r2_read, r1_read, f2_read, f1_read} = cu_gate_pos ? (8'b0000_0001 << {c17a, f11_pos, f10_pos}) : 8'b0000_0000;

endmodule
