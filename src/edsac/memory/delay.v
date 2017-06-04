/* Make the input bit available at the ouput after INTERVAL 
 * pulse intervals, i. e., delay the input by INTERVAL pulse 
 * intervals. A pulse interval was 2us long in the original 
 * machine.
 */

module delay
  #(parameter INTERVAL = 1
   )
   (output wire out,

    input wire  clk,
    input wire  in
   );

   reg [INTERVAL:0] store;
   integer          i;

   initial
     store = 0;

   // Propagate bits towards the output.
   always @(posedge clk) begin
      for (i = 0; i < INTERVAL; i = i + 1)
        store[i] <= store[i+1];
      store[INTERVAL] <= in;
   end

   always @(negedge clk) begin
      if (store[0])
        store[0] <= 1'b0;
   end

   assign out = store[0];

endmodule
