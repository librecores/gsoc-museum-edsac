/* Module for Engineers Control Panel.
 */

module engineer_control_panel (
  output wire eng_mode_neg,
  output wire eng_order,
  output wire order_clr,

  input wire  d0,
  input wire  d18,
  input wire  d19,
  input wire  d20,
  input wire  d21,
  input wire  d22,
  input wire  d23,
  input wire  d24,
  input wire  d25,
  input wire  d26,
  input wire  d27,
  input wire  d28,
  input wire  d29,
  input wire  d30,
  input wire  d31,
  input wire  d32,
  input wire  d33,
  input wire  d34,
  input wire  d35,
  input wire  o1_t_btn,
  input wire  o2_t_btn,
  input wire  o3_t_btn,
  input wire  o4_t_btn,
  input wire  o5_t_btn,
  input wire  o6_t_btn,
  input wire  o7_t_btn,
  input wire  o8_t_btn,
  input wire  o9_t_btn,
  input wire  o10_t_btn,
  input wire  o11_t_btn,
  input wire  o12_t_btn,
  input wire  o13_t_btn,
  input wire  o14_t_btn,
  input wire  o15_t_btn,
  input wire  o16_t_btn,
  input wire  o17_t_btn,
  input wire  eng_mode_t_btn
  );

  wire eng_out;
  wire ff_out;

  assign eng_out = (o1_t_btn & d19) |
                   (o2_t_btn & d20) |
                   (o3_t_btn & d21) |
                   (o4_t_btn & d22) |
                   (o5_t_btn & d23) |
                   (o6_t_btn & d24) |
                   (o7_t_btn & d25) |
                   (o8_t_btn & d26) |
                   (o9_t_btn & d27) |
                   (o10_t_btn & d28) |
                   (o11_t_btn & d29) |
                   (o12_t_btn & d30) |
                   (o13_t_btn & d31) |
                   (o14_t_btn & d32) |
                   (o15_t_btn & d33) |
                   (o16_t_btn & d34) |
                   (o17_t_btn & d35);

  assign eng_mode_neg = ~eng_mode_t_btn;
  assign eng_order = eng_out & eng_mode_t_btn;
  assign order_clr = ff_out & eng_mode_t_btn;

  flipflop ff (
    .out     (ff_out),
    .out_bar (), // Unconnected.
    .set     (d18),
    .reset   (d0)
    );

endmodule
