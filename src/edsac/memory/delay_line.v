module delay_line
  #(parameter STORE_LEN  = 16,
    parameter WORD_WIDTH = 36
    )
   (output reg                            data_out,
    output reg [STORE_LEN*WORD_WIDTH-1:0] monitor,

    input wire                            clk,
    input wire                            data_in,
    input wire                            data_out_gate,
    input wire                            data_in_gate,
    input wire                            data_clr
   );

   reg [STORE_LEN*WORD_WIDTH-1:0] store;
   integer                        i;

   initial begin
      data_out = 1'bz;
      // Assuming stores in delay lines were cleared 
      // manually before commencing operation.
      store = 0;
   end

   // Recirculation logic.
   always @(posedge clk) begin
      for (i = 0; i < STORE_LEN*WORD_WIDTH-1; i = i + 1)
        store[i] <= store[i+1];

      // Assuming one bit is cleared with each 
      // clock cycle when data_clr is high.
      if (data_in_gate)
        store[STORE_LEN*WORD_WIDTH-1] <= data_in;
      else if (data_clr)
        store[STORE_LEN*WORD_WIDTH-1] <= 1'b0;
      else
        store[STORE_LEN*WORD_WIDTH-1] <= store[0];
   end

   always @(*) begin
      data_out = data_out_gate ? store[0] : 1'bz;
      monitor[STORE_LEN*WORD_WIDTH-1:0] = store[STORE_LEN*WORD_WIDTH-1:0];
   end

endmodule
