module acc_shift_i (
  output wire       mob8,
  output wire [3:0] x, // Gating EMFs to ASU II. x[0] corresponds to x1 of original logic, x[1] to x2 and so on.

  input wire        clk,
  input wire        g5, // Accumulator shifting gate.
  input wire        c7, // Right shift.
  input wire        c8, // Left shift.
  input wire        acc,
  input wire        g13,
  input wire        c19, // Store instructions T, U.
  input wire        d17,
  input wire        d35,
  input wire        f1_neg
  );

  wire tmp;

  assign x[0] = g5 & c7;
  assign x[1] = ~x[0];
  assign x[2] = ~x[3];
  assign x[3] = g5 & c8;

  assign tmp = (f1_neg & d17) | d35;
  assign mob8 = g13 & acc & c19 & ~tmp & clk;

endmodule
