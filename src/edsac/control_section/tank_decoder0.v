/* The original machine's initial version had 32 Memory Tanks, 
 * distributed over four racks (8 Tanks per rack). Each Tank was
 * capable of holding 16 full words of 36 bits length 72 us delay. 
 * 
 * This is the first level of Tank decoding. Uses two most significant 
 * bits of the Tank Number field (bits 10 and 11, corresponding 
 * f10_pos and f11_pos respectively) to determine rack to be selected. 
 * Additional control signal, c17a gated with cu_gate_pos, determines 
 * access type - read or write.
 */

module tank_decoder0
  (output wire f1_read,
   output wire f1_write,
   output wire f2_read,
   output wire f2_write,
   output wire r1_read,
   output wire r1_write,
   output wire r2_read,
   output wire r2_write,

   input wire  c17a,
   input wire  f10_pos,
   input wire  f11_pos,
   input wire  cu_gate_pos
  );

   assign {r2_write, r1_write, f2_write, f1_write, r2_read, r1_read, f2_read, f1_read} = cu_gate_pos ? (8'b0000_0001 << {c17a, f11_pos, f10_pos}) : 8'b0000_0000;

endmodule
