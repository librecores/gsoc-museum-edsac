/* Multiplicand Tank is a 36 bit 72 us delay line. This serves as an input 
 * to the Computer (arithmetic unit).
 * 
 * Multiplicand Tank is a rather peculiar logic. During Stage 1, the Multiplicand 
 * is always cleared. 
 * 
 * When Stage 2 is in effect, two possibilities exist - 
 * instructions that DO require memory read, and instructions that DO NOT. 
 * In the former case, when g11_neg is high, both MIB and multiplicand store 
 * is admitted in; and when g11_neg is low, only MIB passes through. Outputs 
 * in both cases are routed to "left-shift pre-processing" just before entering 
 * into the multiplicand store. In the latter case, when g11_neg is low, 
 * the multiplicand store is cleared; and when g11_neg is high, recirculation 
 * occurs.
 * 
 * There is a third scenario when the machine is neither in Stage 1 nor Stage 2, 
 * and it arises in case of single instruction execution. The behaviour of Mutliplicand 
 * Tank in such a case is like the latter possibility discussed just above.
 */

module multiplicand
  (output wire da_n, // Result of test Multiplicand sign.
   output wire mcand,
   output wire mcand_in, // Access to data going into Multiplicand.

   input wire  clk,
   input wire  c1, // For A, S, C, V, N orders, i.e., operations that require number from memory.
   input wire  c21, // O-order.
   input wire  da_m, // Sign test pulse for Multiplicand, originating in CCU 2.
   input wire  g2_pos, // Multiplicand and Shifting gate.
   input wire  g2_neg, // Inverse Multiplicand and Shifting gate.
   input wire  g3_pos, // Multiplicand output.
   input wire  g6_pos, // Multiplicand shift for A, S, C orders.
   input wire  g11_neg, // Inverse multiplicand clear gate.
   input wire  g12, // Stage 1 of Main Control.
   input wire  g13, // Stage 2 of Main Control.
   input wire  mib // Main Input Bus.
  );

   reg [35:0] mcand_store;
   integer    i;
   wire       mcand_ppi;
   wire       mcand_ppo;
   wire       pp_dl_out;

   initial begin
      mcand_store[35:0] = 0;
   end

   assign mcand_in  = mib & g13 & (c1 | c21);
   assign mcand_ppi = (mcand_store[0] & ~g12 & g11_neg) | mcand_in;

   delay #(.INTERVAL(1)) pp_dl
     (.out (pp_dl_out),
      .clk (clk),
      .in  (mcand_ppi)
     );

   assign mcand_ppo = g2_pos ? pp_dl_out : mcand_ppi;

   always @(posedge clk) begin
      for (i = 0; i < 35; i = i + 1)
        mcand_store[i] <= mcand_store[i+1];
      mcand_store[35] <= mcand_ppo;
   end

   assign mcand = mcand_ppi & (g3_pos | g6_pos);
   assign da_n = mcand_ppi & da_m;

endmodule
