/* Counter has an 18 bit 36 us delay line along with a half adder to increment 
 * value on either of d1 or d19 pulses, i.e., twice every minor cycle.
 * 
 * Counter is in a cleared state before commencing operation.
 * 
 * TODO: How is the functioning of Starter Unit and SCT related?
 * 
 * TODO: Does the half adder in Counter have a 1 p.i. 
 *       delay that half adders in the machine are usually subject to? 
 *       To answer this, consider the CU. Coincidence is sought only 
 *       within the window d2 to d7 (excluding d7), which means the inputs 
 *       to CU from Counter and SCT must arrive within this window (of course 
 *       the two arriving inputs must also align with each other). Counter 
 *       increments twice every minor cycle, at d1 and d19. Thus, Conuter output 
 *       must arrive 1 p.i. later. This is a hypothesis and needs to be validated, 
 *       but for now the modules assume this hypothesis to be true.
 * 
 * TODO: The original report says that the Counter keeps count of minor cycles, 
 *       which would imply that it should be incremented once every minor cycle. 
 *       The logic diagram, however, shows increment twice every minor cycle.
 *       The d2 pulse causes the increment. It should be noted that coincidene 
 *       between counter and order/SCT is sought in the CU during d2 to d6 (both 
 *       inclusive), so it would make sense that d2 become the LSB of Counter.
 * 
 * TODO: The logic diagram description says the Counter is incremented at d2 and 
 *       d20, whereas the diagram itself depicts d1 and d19 to increment the Counter.
 */

module counter
  (output wire cntr,

   input wire  clk,
   input wire  d1,
   input wire  d19,
   input wire  reset_cntr_neg // From Starter Unit. Active low.
  );

   wire cntr_store_out;
   wire cntr_store_in;
   wire increment;
   wire hf_out;

   assign increment     = d1 | d19;
   assign cntr_store_in = hf_out & reset_cntr_neg;

   // 36 us 18 bit delay line.
   delay #(.INTERVAL(18)) cntr_store
     (.out (cntr_store_out),
      .clk (clk),
      .in  (cntr_store_in)
     );

   half_adder hf
     (.sum       (hf_out),
      .del_carry (), // Unconnected.
      .clk       (clk),
      .a         (cntr_store_out),
      .b         (increment)
     );

   delay #(.INTERVAL(1)) cntr_dl
     (.out (cntr),
      .clk (clk),
      .in  (cntr_store_in)
     );

endmodule
