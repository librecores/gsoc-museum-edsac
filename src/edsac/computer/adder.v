/* The original machine's logic reconstruction 
 * indicates presence of an input signal evD1 
 * which is ignored here for now.
 */

module adder
  (output wire sum,

   input wire  clk,
   input wire  a,
   input wire  b
  );

  wire sum0;
  wire carry0_d;
  wire carry_d;
  wire c;

  half_adder ha0
    (.sum       (sum0),
     .del_carry (carry0_d),

     .clk       (clk),
     .a         (a),
     .b         (b)
    );

  half_adder ha1
    (.sum       (sum),
     .del_carry (carry_d),

     .clk       (clk),
     .a         (sum0),
     .b         (c)
    );

  assign c = carry0_d | carry_d;

endmodule
