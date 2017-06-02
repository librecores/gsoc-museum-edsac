module memory_r1_down_2
  (output reg monitor23,
   output reg r1_down_mob_t2,

   input wire r1_clk,
   input wire r1_mib,
   input wire r1_down_t2_clr,
   input wire r1_down_t2_in,
   input wire r1_down_t2_out);

   // Atomic dleay_line module to be instantiated here 
   // with 1.152ms delay for circulation of 16 full 
   // words or 32 short words (instructions).

   // Body

endmodule // memory_r1_down_2
