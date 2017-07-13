/* First-level Order Decoder Unit. Two most significant opcode bits are used 
 * to select one of the four second-level Order Decoder Units. Outputs from 
 * second-level Order Decoder Units are directly routed to Order Coder.
 * 
 * TODO: f16_neg and f17_neg are unused below but the original machine 
 *       made use of it. (Should it be kept around?)
 */

module order_decoder1 (
  output wire o_dy_0,
  output wire o_dy_1,
  output wire o_dy_2,
  output wire o_dy_3,

  input wire f16_pos, // Order bit 16 (opcode bit 3). From Order Flashing Unit.
  input wire f16_neg,
  input wire f17_pos, // Order bit 17 (opcode bit 4), most significant. From Order Flashing Unit.
  input wire f17_neg,
  input wire order_flash_rdy // Indicates Order Flashing flipflops are set.
  );

  wire [1:0] count = {f17_pos, f16_pos};

  assign {o_dy_3, o_dy_2, o_dy_1, o_dy_0} = order_flash_rdy ? (4'b0001 << count[1:0]) : 4'b0000;

endmodule
