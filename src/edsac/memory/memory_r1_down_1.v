module memory_r1_down_1
  (output reg monitor22,
   output reg r1_down_mob_t1,

   input wire r1_clk,
   input wire r1_mib,
   input wire r1_down_t1_clr,
   input wire r1_down_t1_in,
   input wire r1_down_t1_out);

   // Atomic dleay_line module to be instantiated here 
   // with 1.152ms delay for circulation of 16 full 
   // words or 32 short words (instructions).

   // Body

endmodule // memory_r1_down_1
