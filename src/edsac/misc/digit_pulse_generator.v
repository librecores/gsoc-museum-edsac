module digit_pulse_generator
  (output wire [35:0] digit_pulse,

   input wire         clk
  );

   reg [5:0]   count = 6'b00_0000;
   wire [35:0] outi;
   genvar      i;
   genvar      j;

   always @(negedge clk) begin
      if (count == 6'b01_1100)
        count <= 6'b11_1111;
      else
        count <= count - 6'b00_0001;
   end

   assign outi[0] = (count[5:0] == 6'b11_1111);

   generate
      for (i = 1; i < 36; i = i + 1) begin
         delay #(.INTERVAL(1)) dl
               (.out (outi[i]),
                .clk (clk),
                .in  (outi[i-1])
               );
      end
   endgenerate

   generate
      for (j = 0; j < 36; j = j + 1) begin
         assign digit_pulse[j] = outi[j] & clk;
      end
   endgenerate

endmodule
