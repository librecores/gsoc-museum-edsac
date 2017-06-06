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
