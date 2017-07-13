/* CCU 6 combines various end pulses (ep0, ep1, ...) and 
 * passes on to MCU, and merges sign insertion/propagation 
 * pulses.
 */

module ccu_6 (
   output wire ep,
   output wire ccu_ones,

   input wire  ep0,
   input wire  ep1,
   input wire  ep2,
   input wire  ep3,
   input wire  ep4,
   input wire  ep5,
   input wire  ep6,
   input wire  ep7,
   input wire  ep8,
   input wire  ep9,
   input wire  ep10,
   input wire  ep11,
   input wire  ones1,
   input wire  ones2,
   input wire  ones4
   );

   assign ep       = ep0 | ep1 | ep2 | ep3 | ep4 | ep5 | ep6 | ep7 | ep8 | ep9 | ep10 | ep11;
   assign ccu_ones = ones1 | ones2 | ones4;

endmodule
