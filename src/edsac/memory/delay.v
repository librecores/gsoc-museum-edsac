/* Copyright 2017 Hatim Kanchwala
 *
 * Contributor Hatim Kanchwala <hatim@hatimak.me>
 *
 * This file is licensed under the CERN OHL v. 1.2. You may redistribute and 
 * modify this documentation under the terms of the 
 * CERN OHL v.1.2. (http://ohwr.org/cernohl). This documentation is distributed 
 * WITHOUT ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING OF MERCHANTABILITY, 
 * SATISFACTORY QUALITY AND FITNESS FOR A PARTICULAR PURPOSE. Please see the 
 * CERN OHL v.1.2 for applicable conditions.
 */
 
 module delay
  #(parameter INTERVAL = 1
   )
   (output wire out,

    input wire  clk,
    input wire  in
   );

   reg data_clr = 1'b1;
   reg data_in_gate = 1'b1;

   delay_line #(.STORE_LEN(1), .WORD_WIDTH(INTERVAL)) dl
     (.monitor      (),
      .data_out     (out),

      .clk          (clk),
      .data_in      (in),
      .data_in_gate (data_in_gate),
      .data_clr     (data_clr)
     );

endmodule
