/* Module for Tape Reader Unit.
 */

module tape (
  output wire rdr_busy,
  output wire ep8,
  output wire mob_tape,
  output wire stop_one_a,

  input wire  ep_done,
  input wire  r2,
  input wire  s2,
  input wire  c16,
  input wire  d18,
  input wire  d19,
  input wire  d20,
  input wire  d21,
  input wire  d22
  );

endmodule
