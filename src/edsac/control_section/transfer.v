/* The Transfer Unit is primarily the Bus system of the EDSAC. 
 * It has a half-minor cycle delay tank to ensure that short 
 * numbers that are transferred from the memory are aligned 
 * properly. Since EDSAC operates on real numbers, the decimal 
 * point must coincide.
 */

module transfer (
  output wire mib,
  output wire mob,

  input wire  clk,
  input wire  f1_pos, // Indicates instruction length, when high, long word.
  input wire  f2_pos,  // Indicates which half of the M/C the short word 
                       // occupies - when high, second half.
  input wire  mob_asu1,
  input wire  mob_tape,
  input wire  mob_starter,
  input wire  mob_printer,
  input wire  f1_mob, // Output bus from Rack F1 - 8 Memory tanks.
  input wire  f2_mob, // Output bus from Rack F2 - 8 Memory tanks.
  input wire  r1_mob, // Output bus from Rack R1 - 8 Memory tanks.
  input wire  r2_mob // Output bus from Rack R2 - 8 Memory tanks.
  );

  wire mob_delay;
  wire mob_tmp;

  // OR-ing the output buses from various subsystems of EDSAC.
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
