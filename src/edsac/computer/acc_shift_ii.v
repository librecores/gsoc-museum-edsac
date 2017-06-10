module acc_shift_ii
  (output wire      adder_a,

   input wire       clk,
   input wire       acc1,
   input wire [3:0] x // Gating EMFs from ASU I. x[0] corresponds to x1 of original logic, x[1] to x2 and so on.
  );

   wire in_dl1;
   wire in_dl2;
   wire in_dl3;
   wire out_dl1;
   wire out_dl2;
   wire out_dl3;
   wire or1;

   delay #(.INTERVAL(1)) d1
     (.out (out_dl1),
      .clk (clk),
      .in  (in_dl1)
     );

   delay #(.INTERVAL(1)) d2
     (.out (out_dl2),
      .clk (clk),
      .in  (in_dl2)
     );

   delay #(.INTERVAL(1)) d3
     (.out (out_dl3),
      .clk (clk),
      .in  (in_dl3)
     );

   assign in_dl1  = acc1 & x[1];
   assign or1     = (x[0] & acc1) | (out_dl1 & clk);
   assign in_dl2  = x[3] & or1;
   assign in_dl3  = (x[2] & or1) | (out_dl2 & clk);
   assign adder_a = out_dl3 & clk;

endmodule
