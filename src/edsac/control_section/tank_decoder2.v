/* This is the top level of final stage of Tank decoding. Uses 
 * least two significant bits of the Tank Number field 
 * (bit 7 and 8, corresponding to f7_pos/f7_neg and f8_pos/f8_neg 
 * respectively) to determine particular Memory Tank to select 
 * at location (up or down) within rack. Additional control signals 
 * from previous level used.
 * 
 * Tank Decoder 2's are 8 in number, one for each group of 4 Memeory Tanks.
 */

module tank_decoder2 (
  output wire rack_loc_t0_in,
  output wire rack_loc_t1_in,
  output wire rack_loc_t2_in,
  output wire rack_loc_t3_in,
  output wire rack_loc_t0_out,
  output wire rack_loc_t1_out,
  output wire rack_loc_t2_out,
  output wire rack_loc_t3_out,

  input wire  rack_loc_f7_pos, // Tank address bit 7 (from Tank Distribution Unit).
  input wire  rack_loc_f7_neg, // Inverted Tank address bit 7 (from Tank Distribution Unit).
  input wire  rack_loc_f8_pos, // Tank address bit 8 (from Tank Distribution Unit).
  input wire  rack_loc_f8_neg, // Inverted Tank address bit 8 (from Tank Distribution Unit).
  input wire  rack_loc_t_in,
  input wire  rack_loc_t_out
  );

  wire [1:0] count;
  assign count[1:0] = {rack_loc_f8_pos, rack_loc_f7_pos};

  assign {rack_loc_t3_out, rack_loc_t2_out, rack_loc_t1_out, rack_loc_t0_out} = rack_loc_t_out ? (4'b0001 << count) : 4'b0000;
  assign {rack_loc_t3_in, rack_loc_t2_in, rack_loc_t1_in, rack_loc_t0_in} = rack_loc_t_in ? (4'b0001 << count) : 4'b0000;

endmodule
