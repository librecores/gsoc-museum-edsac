module delay_line
  #(parameter STORE_LEN  = 16,
    parameter WORD_WIDTH = 36
   )
   (output reg [STORE_LEN*WORD_WIDTH-1:0] monitor,
    output reg                            data_out,

    input wire                            clk,
    input wire                            data_in,
    input wire                            data_in_gate,
    input wire                            data_clr
   );

   reg [STORE_LEN*WORD_WIDTH-1:0] store;
   integer                        i;

   initial begin
      // Assuming stores in delay lines were cleared.
      monitor = 0;
      store = 0;
      data_out = 1'b0;
   end

   // Recirculation logic.
   always @(posedge clk) begin
      for (i = 0; i < STORE_LEN*WORD_WIDTH-1; i = i + 1)
        store[i] <= store[i+1];

      // Assuming one bit is cleared with each clock cycle when 
      // data_clr is low (active low). Original machine behaviour 
      // documentation not found in this regard.
      if (data_in_gate)
        store[STORE_LEN*WORD_WIDTH-1] <= data_in;
      else if (~data_clr)
        store[STORE_LEN*WORD_WIDTH-1] <= 1'b0;
      else
        store[STORE_LEN*WORD_WIDTH-1] <= store[0];
   end

   always @(negedge clk) begin
      monitor[STORE_LEN*WORD_WIDTH-1:0] <= store[STORE_LEN*WORD_WIDTH-1:0];
      data_out <= store[0];
   end

endmodule
