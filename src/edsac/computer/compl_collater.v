/* Complementer/Collater/Distribution Unit III is a composite unit that serves
 * multiple purposes - complementing numbers from the multiplicand, collate
 * numbers and introduce delay when necessary to bring in numbers in step
 * with those from ASU as they go into the Adder.
 */
module compl_collater (
  output wire adder_b,

  input wire clk,
  input wire c2, // A order - add number into accumulator.
  input wire c3, // S order - subtract.
  input wire c4, // C order - collate with Multiplier and add into accumulator.
  input wire c7, // R order - right shift.
  input wire c9, // X, Y orders.
  input wire ccu_ones, // Sign insertion/propagation pulses.
  input wire ev_d1_dz, // Logic diagram describes as, "early
                      // d1 during even cycles to stop inserting ones".
  input wire g4_pos, // Complementer gate.
  input wire g4_neg, // Inverse complementer gate.
  input wire mcand, // Number from Multiplicand.
  input wire mplier // Number from Multiplier.
  );

  wire ff_out;
  wire ff_set;
  wire ff_out_bar;
  wire mcand_del; // Multiplicand input delayed by 1 p.i.
  wire comp_in;
  wire comp_out;
  wire coll_out;
  wire add_out;
  wire misc_out;
  wire fin_del_in;

  // COMPLEMENTING BLOCK
  // TODO: The purpose of this delay is NOT clear. The logic diagram has used this.
  delay #(.INTERVAL(1)) dl_mcand (
    .out (mcand_del),
    .clk (clk),
    .in  (mcand)
    );

  assign comp_in = (c3 & mcand) | (g4_neg & mcand_del);
  assign ff_set = comp_in & ff_out_bar;

  flipflop ff (
    .out     (ff_out),
    .out_bar (ff_out_bar),
    .set     (ff_set),
    .reset   (ev_d1_dz)
    );

  assign comp_out = ~comp_in & ff_out; // TODO: Logic diagram shows clk as the third
                                       // input signal, probably to reshape waveform.
                                       // That is NOT implemented here.

  // COLLATION BLOCK
  assign coll_out = mcand & mplier & c4;

  // A-ORDER PASS THROUGH BLOCK
  assign add_out = c2 & mcand;

  // MISC. BLOCK (better name needed)
  assign misc_out = (g4_pos & mcand_del) | (ccu_ones & (c7 | c9 | g4_pos));

  // FINAL BLOCK
  assign fin_del_in = comp_out | ff_set | add_out | coll_out | misc_out;

  // TODO: Logic diagram shows adder_b waveform is reshaped by clk before final output.
  delay #(.INTERVAL(1)) fin_del (
    .out (adder_b),
    .clk (clk),
    .in  (fin_del_in)
    );

endmodule
