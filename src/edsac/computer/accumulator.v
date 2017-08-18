module accumulator (
  output wire acc, // Gated output to ASU I.
  output wire acc1, // Least significant half of Accumulator, output to ASU II.
  output wire ds_r, // Sign bit propagation for right shifts.
  output wire dv_d, // Jump condition satisfied.

  input wire  clk,
  input wire  adder_sum,
  input wire  c10, // G-order, jump if accumulator negative (< 0).
  input wire  c25, // E-order, jump is accumulator positive (>= 0).
  input wire  ds, // Sign test for right shifts
  input wire  dv, // Sign test for E-order.
  input wire  g1_pos, // Odd cycles gate.
  input wire  g1_neg, // Even cycles gate.
  input wire  g9_neg, // Accumulator clear gate.
  input wire  jump_uc
  );

  wire acc1_out;
  wire acc2_out;
  wire acc1_in;

  // 1 M/C (= 36 p.i.) delay Accumulator I
  delay #(.INTERVAL(36)) acc_store_1 (
    .out (acc1_out),
    .clk (clk),
    .in  (acc1_in)
    );

  // 1 M/C - 4 p.i. (= 32 p.i.) delay Accumulator II
  delay #(.INTERVAL(32)) acc_store_2 (
    .out (acc2_out),
    .clk (clk),
    .in  (adder_sum)
    );

  // TODO: Signal reconstruction _may_ be needed to get full-cycle bit level.
  assign acc1_in = acc2_out & g9_neg;
  assign acc1    = acc1_out & g9_neg;
  assign acc     = (g1_pos & acc1_out) | (g1_neg & acc2_out);

  assign dv_d    = (jump_uc | (c25 & ~acc) | (c10 & acc)) & dv;
  assign ds_r    = ds & acc;

endmodule
