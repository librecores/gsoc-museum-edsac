/* The original machine's initial version had 32 Memory Tanks, 
 * distributed over four racks (8 Tanks per rack). Within each 
 * rack, 4 Tanks were located up and 4 down. Each Tank was
 * capable of holding 16 full words of 36 bits length 72 us delay. 
 * 
 * This is the top level of second stage of Tank decoding. Uses 
 * third most significant bit of the Tank Number field (bit 9, 
 * corresponding to f9_pos) to determine location (up or down) 
 * within rack to be selected. Additional control signals from 
 * previous level used.
 * 
 * Tank Decoder 1's are 4 in number, one for each rack.
 * 
 * TODO: Clock pulses to Memory Tanks were gated by a cls_neg signal. 
 *       That is NOT implemented here.
 * TODO: The OR-ed rack_loc_mob_tn signals output on to mob is redundant, 
 *       and so is forwarding mib to rack_mib. But is still followed 
 *       in the spirit of faithful replication. (?) The original motivation 
 *       must have been to have MIB/MOB per tank which would be bundled 
 *       into MIB/MOB per rack.
 * TODO: In-gates to Memory Tanks are inverted and routed to clear-gates 
 *       of corresponding Memory Tanks. The original motivation must have
 *       been to inhibit recirculation when data is fed into the Tanks. 
 *       As far as design of bottom-level delay_line module goes (upon which 
 *       the Memory Tank modules are built), this arrangement of inverting 
 *       is redundant. As per our delay_line design, data_in_gate gates both 
 *       recirculation and data_in, so inverting in-gates becomes redundant.
 */

module tank_decoder1
  (output wire rack_down_in,
   output wire rack_up_in,
   output wire rack_down_out,
   output wire rack_up_out,
   output wire rack_down_t0_clr,
   output wire rack_up_t0_clr,
   output wire rack_down_t1_clr,
   output wire rack_up_t1_clr,
   output wire rack_down_t2_clr,
   output wire rack_up_t2_clr,
   output wire rack_down_t3_clr,
   output wire rack_up_t3_clr,
   output wire rack_mib,
   output wire rack_mob,

//   input wire  clk,
   input wire  rack_read,
   input wire  rack_write,
   input wire  f9_pos, // Tank address bit 9.
//   input wire  cls_neg,
   input wire  rack_down_mob_t0,
   input wire  rack_up_mob_t0,
   input wire  rack_down_mob_t1,
   input wire  rack_up_mob_t1,
   input wire  rack_down_mob_t2,
   input wire  rack_up_mob_t2,
   input wire  rack_down_mob_t3,
   input wire  rack_up_mob_t3,
   input wire  rack_down_t0_in,
   input wire  rack_up_t0_in,
   input wire  rack_down_t1_in,
   input wire  rack_up_t1_in,
   input wire  rack_down_t2_in,
   input wire  rack_up_t2_in,
   input wire  rack_down_t3_in,
   input wire  rack_up_t3_in,
   input wire  mib
  );

   wire[2:0] count = {rack_write, rack_read, f9_pos};
   /*  rack_write  rack_read  f9_pos  |
    * --------------------------------+----------------------
    *      0           1        0     | rack_up_out   (0001)
    *      0           1        1     | rack_down_out (0010)
    *      1           0        0     | rack_up_in    (0100)
    *      1           0        1     | rack_down_in  (1000)
    */
   assign {rack_down_in, rack_up_in, rack_down_out, rack_up_out} = 4'b0001 << (count - 4'b0010);

   assign rack_mib = mib;
   assign rack_mob = rack_down_mob_t0 |
                     rack_up_mob_t0   |
                     rack_down_mob_t1 |
                     rack_up_mob_t1   |
                     rack_down_mob_t2 |
                     rack_up_mob_t2   |
                     rack_down_mob_t3 |
                     rack_up_mob_t3;

   // Memory Tank in-gate inverting logic to inhibit recirculation.
   assign rack_down_t0_clr = ~rack_down_t0_in;
   assign rack_up_t0_clr   = ~rack_up_t0_in;
   assign rack_down_t1_clr = ~rack_down_t1_in;
   assign rack_up_t1_clr   = ~rack_up_t1_in;
   assign rack_down_t2_clr = ~rack_down_t2_in;
   assign rack_up_t2_clr   = ~rack_up_t2_in;
   assign rack_down_t3_clr = ~rack_down_t3_in;
   assign rack_up_t3_clr   = ~rack_up_t3_in;

endmodule
