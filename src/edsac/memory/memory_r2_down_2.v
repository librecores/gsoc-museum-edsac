module memory_r2_down_2
  (output reg monitor31,
   output reg r2_down_mob_t2,

   input wire r2_clk,
   input wire r2_mib,
   input wire r2_down_t2_clr,
   input wire r2_down_t2_in,
   input wire r2_down_t2_out);

   // Atomic dleay_line module to be instantiated here 
   // with 1.152ms delay for circulation of 16 full 
   // words or 32 short words (instructions).

   // Body

endmodule // memory_r2_down_2
