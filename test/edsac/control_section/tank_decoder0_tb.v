module tank_decoder0_tb();

   reg [2:0] count; // count[2] corresponds to c17a, count[1] to f11_pos, 0 to f10_pos.
   reg       cu_gate;
   wire      f1_read;
   wire      f1_write;
   wire      f2_read;
   wire      f2_write;
   wire      r1_read;
   wire      r1_write;
   wire      r2_read;
   wire      r2_write;

   tank_decoder0 td0
     (.f1_read     (f1_read),
      .f1_write    (f1_write),
      .f2_read     (f2_read),
      .f2_write    (f2_write),
      .r1_read     (r1_read),
      .r1_write    (r1_write),
      .r2_read     (r2_read),
      .r2_write    (r2_write),

      .c17a        (count[2]),
      .f10_pos     (count[0]),
      .f11_pos     (count[1]),
      .cu_gate_pos (cu_gate)
     );

   initial begin
      $dumpfile("tank_decoder0.vcd");
      $dumpvars(0, tank_decoder0_tb);
      cu_gate = 1'b0;
      count = 3'b000;
      #60 cu_gate = 1'b1;
      #300 $finish;
   end

   always #10 count = count + 3'b001;

endmodule
