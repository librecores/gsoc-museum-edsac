module memory
  (output reg monitor,
   output reg rack_loc_mob_t,

   input wire rack_clk,
   input wire rack_mib,
   input wire rack_loc_t_clr,
   input wire rack_loc_t_in,
   input wire rack_loc_t_out);

   // Atomic dleay_line module to be instantiated here 
   // with 1.152ms delay for circulation of 16 full 
   // words or 32 short words (instructions).

   // Body

endmodule // memory
