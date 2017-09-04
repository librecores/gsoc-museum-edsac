/* Logic diagram for module not available
 * in original report by Wilkes.
 */

module order_coder
  (output wire c1,
   output wire c2,
   output wire c3,
   output wire c4,
   output wire c5,
   output wire c6,
   output wire c7,
   output wire c8,
   output wire c9,
   output wire c10,
   output wire c11,
   output wire c12,
   output wire c13,
   output wire c14,
   output wire c16,
   output wire c17,
   output wire c17a,
   output wire c18,
   output wire c19,
   output wire c20,
   output wire c21,
   output wire c22,
   output wire c24,
   output wire c25,
   output wire c26,
   output wire c27,


   input wire  op_a,
   input wire  op_b,
   input wire  op_blank,
   input wire  op_c,
   input wire  op_d,
   input wire  op_delta,
   input wire  op_e,
   input wire  op_erase,
   input wire  op_f,
   input wire  op_g,
   input wire  op_h,
   input wire  op_i,
   input wire  op_j,
   input wire  op_k,
   input wire  op_l,
   input wire  op_m,
   input wire  op_n,
   input wire  op_o,
   input wire  op_p,
   input wire  op_phi,
   input wire  op_pi,
   input wire  op_q,
   input wire  op_r,
   input wire  op_s,
   input wire  op_t,
   input wire  op_theta,
   input wire  op_u,
   input wire  op_v,
   input wire  op_w,
   input wire  op_x,
   input wire  op_y,
   input wire  op_z,
   input wire  starter,
   input wire  starter_neg,
   input wire  extended_neg
  );

   assign c1   = op_a | op_s | op_c | op_v | op_n;
   assign c2   = op_a;
   assign c3   = op_s;
   assign c4   = op_c;
   assign c5   = op_v | op_n;
   assign c6   = op_r | op_l;
   assign c7   = op_r;
   assign c8   = op_l;
   assign c9   = op_x | op_y;
   assign c10  = op_g;
   assign c11  = op_n;
   assign c12  = op_x;
   assign c13  = op_y;
   assign c14  = op_v;
   assign c16  = op_i;
   assign c17  = op_t | op_u | op_i | op_f;
   assign c17a = starter | op_f | op_i | op_t | op_u;
   assign c18  = op_h;
   assign c19  = op_t | op_u;
   assign c20  = op_t;
   assign c21  = op_o;
   assign c22  = op_pi | op_k | op_erase | op_blank | op_theta | op_d | op_phi | op_m | op_delta | op_b | op_z | op_q | op_w | (op_j & extended_neg) | (starter_neg & op_p);
   assign c24  = op_h | op_c;
   assign c25  = op_e;
   assign c26  = op_h | op_a | op_s | op_c | op_v | op_n;
   assign c27  = op_i | op_o;

endmodule
