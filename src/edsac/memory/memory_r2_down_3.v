module memory_r2_down_3
  (output reg monitor32,
   output reg r2_down_mob_t3,

   input wire r2_clk,
   input wire r2_mib,
   input wire r2_down_t3_clr,
   input wire r2_down_t3_in,
   input wire r2_down_t3_out);

   // Atomic dleay_line module to be instantiated here 
   // with 1.152ms delay for circulation of 16 full 
   // words or 32 short words (instructions).

   // Body

endmodule // memory_r2_down_3
