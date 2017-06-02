module memory_f1_up_1
  (output reg monitor2,
   output reg f1_up_mob_t1,

   input wire f1_clk,
   input wire f1_mib,
   input wire f1_up_t1_clr,
   input wire f1_up_t1_in,
   input wire f1_up_t1_out);

   // Atomic dleay_line module to be instantiated here 
   // with 1.152ms delay for circulation of 16 full 
   // words or 32 short words (instructions).

   // Body

endmodule // memory_f1_up_1
