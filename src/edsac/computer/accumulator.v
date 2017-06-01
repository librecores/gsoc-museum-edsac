module accumulator(
                   // Outputs
                   acc, acc1, acc2, ds_r, dv_d,
                   // Inputs
                   clk, adder_sum, c10, c25, ds, dv, g1_pos, g1_neg, g9_neg, jump_uc
                   );

   output reg acc;
   output reg acc1;
   output reg acc2;
   output reg ds_r;
   output reg dv_d;

   input wire clk;
   input wire adder_sum;
   input wire c10;
   input wire c25;
   input wire ds;
   input wire dv;
   input wire g1_pos;
   input wire g1_neg;
   input wire g9_neg;
   input wire jump_uc;

   // Body

endmodule // accumulator
