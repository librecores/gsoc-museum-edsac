/* The EDSAC had 32 memory tanks, each designed to hold 
 * 16 full words (36 bits, 72 us delay). It took 1.152 ms for 
 * one complete circulation. Thus 512 full words (576 bits) 
 * could be stored in all. Later in its lifetime, the capacity 
 * was doubled to 1024 full words.
 * 
 * The 32 tanks are distributed across 4 racks -
 *     - rack F1, 8 tanks = 4 up + 4 down
 *     - rack F2, 8 tanks = 4 up + 4 down
 *     - rack R1, 8 tanks = 4 up + 4 down
 *     - rack R2, 8 tanks = 4 up + 4 down
 * Thus, the memory module defined below is instantiated 
 * in an 32-length array by the top module. 0th corresponds 
 * to Tank 0 in F1_up, 1st to Tank 1 in F1_up, ... , 
 * 4th to Tank 0 in F1_down, ... and so on.
 */

module memory
   (output wire [575:0] monitor, // External long tank display for full 576 bits.
    output wire         mob_tn,

    input wire          clk,
    input wire          mib,
    input wire          tn_in,
    input wire          tn_clr,
    input wire          tn_out
   );

   delay_line #(.STORE_LEN(16), .WORD_WIDTH(36)) dl
     (.monitor      (monitor),
      .clk          (clk),
      .data_in      (mib),
      .data_in_gate (tn_in),
      .data_clr     (tn_clr)
     );

   assign mob_tn = tn_out ? monitor[0] : 1'bz;

endmodule
