/* CCU 5/6 is concerned with rounding off instructions.
 * 
 * TODO: Prof. Martin's article did not have any opcode to round off to 16 binary 
 *       digits, but the report does contain such an opcode, namely Z2. Does this 
 *       map to the X order in the article (which in turn has no mention 
 *       in the original report).
 * 
 * TODO: The purpose of extended_neg is NOT clear.
 */

module ccu_5 (
  output wire ep0, // End pulse terminating roundoff orders.
  output wire ones4, // Signal to CCU 6 to add 1 at the appropriate place to round off.

  input wire  clk,
  input wire  c9, // X, Y order.
  input wire  c12, // X order.
  input wire  c13, // Y order.
  input wire  d18,
  input wire  ep_done,// From MCU.
  input wire  ev_d0,
  input wire  extended_neg,
  input wire  odd_d0,
  input wire  s2 // Stimulating pulse to Computer from MCU.
  );

  wire s2_del;
  wire od0_set;
  wire od0_out;
  wire od18_set;
  wire od18_out;

  delay #(.INTERVAL(1)) dl_s2 (
    .out (s2_del),
    .clk (clk),
    .in  (s2)
    );

  assign od0_set = c9 & s2_del;

  flipflop ff_od0 (
    .out     (od0_out),
    .out_bar (), // Unconnected.
    .set     (od0_set),
    .reset   (ep_done)
    );

  assign od18_set = odd_d0 & od0_out;

  flipflop ff_od18 (
    .out     (od18_out),
    .out_bar (), // Unconnected.
    .set     (od18_set),
    .reset   (ep_done)
    );

  assign ep0 = od18_out & ev_d0;

  // d18 here is guaranteed to be the odd d18 because 
  // od18_out is raised only by an odd d0.
  // The first bracket here causes an odd d0 to pass 
  // in presence of c13 to round off to 34 binary digits.
  // The second bracket here is for rounding off to 16 
  // binary digits.
  assign ones4 = (c13 & od18_set) | (extended_neg & c12 & d18 & od18_out);

endmodule
