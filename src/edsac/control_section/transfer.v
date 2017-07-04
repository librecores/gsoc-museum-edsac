module transfer (
  output wire mib,
  output wire mob,

  input wire  clk,
  input wire  f1_pos,
  input wire  f2_pos,
  input wire  mob_asu1,
  input wire  mob_tape,
  input wire  mob_starter,
  input wire  mob_printer,
  input wire  f1_mob,
  input wire  f2_mob,
  input wire  r1_mob,
  input wire  r2_mob
  );

  wire mob_delay;
  wire mob_tmp;

  assign mob_tmp = mob_asu1 | mob_tape | mob_starter | mob_printer | f1_mob | f2_mob | r1_mob | r2_mob;

  // Half minor cycle, i.e., 18 p.i. delay
  delay #(.INTERVAL(18)) pp_dl (
    .out (mob_delay),
    .clk (clk),
    .in  (mib)
  );
  assign mob = (f1_pos & mob_tmp) |
               (f2_pos & mob_tmp) |
               (~f2_pos & ~f1_pos & mob_delay);

endmodule
