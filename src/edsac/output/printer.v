/* Module for Printer Unit.
 *
 * TODO: Original Logic diagram shows a monitoring input 
         from Multiplicand, but since its purpose is not 
         understood it is not included here.
 */

module printer (
  output wire prt_busy,
  output wire ep10,
  output wire mob_printer,
  output wire stop_one_c,

  input wire  ep_done,
  input wire  r2,
  input wire  c21,
  input wire  d0,
  input wire  d30,
  input wire  d31,
  input wire  d32,
  input wire  d33,
  input wire  d34,
  input wire  d35,
  input wire  op_f
  );

endmodule
