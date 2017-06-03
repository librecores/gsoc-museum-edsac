/* The EDSAC had 32 memory tanks, each designed to hold 
 * 16 long words (each 36-bit wide). It took 1.152 ms for 
 * one complete circulation. Thus 512 long words could 
 * be stored in all. Later in its lifetime, the capacity 
 * was doubled to 1024 long words.
 * 
 * The 32 tanks are distributed across 4 racks.
 */

module memory
  #(parameter STORE_LEN = 16,
    parameter WORD_WIDTH = 36
   )
   (output wire [STORE_LEN*WORD_WIDTH-1:0] monitor,
    output wire rack_loc_mob_t,

    input wire  rack_clk,
    input wire  rack_mib,
    input wire  rack_loc_t_in,
    input wire  rack_loc_t_clr,
    input wire  rack_loc_t_out
   );

   delay_line #(STORE_LEN, WORD_WIDTH) dl
     (.monitor      (monitor),
      .clk          (rack_clk),
      .data_in      (rack_mib),
      .data_in_gate (rack_loc_t_in),
      .data_clr     (rack_loc_t_clr)
     );

   assign rack_loc_mob_t = rack_loc_t_out ? monitor[0] : 1'bz;

endmodule
