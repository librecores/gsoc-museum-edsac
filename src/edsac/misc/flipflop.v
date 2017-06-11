module flipflop
   (output wire out,
    output wire out_bar,

    input wire  set,
    input wire  reset
   );

   reg outi = 1'b0;

   always @(posedge set) begin
      outi <= 1'b1;
   end

   always @(posedge reset) begin
      outi <= 1'b0;
   end

   assign out = outi;
   assign out_bar = ~out;

endmodule
