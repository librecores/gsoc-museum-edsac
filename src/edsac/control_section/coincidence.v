/* Coincidence Unit is responsible for selecting the position 
 * of a particular word (short or long) within the 16 minor cycles 
 * in circulation in a Memory Tank. CU needs to be engaged in both 
 * the Stage 1 to fetch the order from memory, and in Stage 2 to fetch 
 * data from the memory, if need be.
 * 
 * TOOD: Timing of the coincidence signal (as defined below) is unclear. 
 *       How does it interact with d0, d18, d17, d35? The report says 
 *       that once CU detects coincidence (as defined in report), 
 *       the _following_ half/full cycle is treated as the desired data.
 * 
 * TODO: 1 p.i. delay has been introduced between the d0/d18 pulse and 
 *       its actual arrival at the ff_cu_comp. Theoretical timing diagrams 
 *       indicate this is fine, but need to validate.
 * 
 * TODO: The exact length by which to delay the coincidence signal (as defined 
 *       below) before it moves on to trigger the r_pulse is unclear.
 */

module coincidence (
  output wire cu_gate_pos,
  output wire cu_gate_neg,
  output wire order_sct, // To Tank Number Flashing Unit. Order is gated 
                        // by g13 and SCT by g12 in their respective units.
  output wire r_pulse, // To MCU to signal end of Stage 1 and start of Stage 2. 
                      // Indicates instruction has been transferred into 
                      // the Order Tank.

  input wire  clk,
  input wire  cntr, // From Counter Tank.
  input wire  sct, // From SCT.
  input wire  order, // From Order Tank.
  input wire  s1, // Stimulating pulse from MCU that triggers CU.
  input wire  d2,
  input wire  d20,
  input wire  d7,
  input wire  d25,
  input wire  d0,
  input wire  d18,
  input wire  f1_neg // Inverted order bit 1 indicating instruction length.
  );

  wire comp_res; // CU compare result.
  wire dl_sr_out;
  wire dl_stim_out;
  wire coincidence;
  wire cu_window_set;
  wire cu_window_reset;
  wire cu_window;
  wire ff_cs_out;
  wire ff_cc_out;
  wire ff_cc_set;
  wire dl_cc_in;
  wire dl_cgr_out;
  wire ff_cu_gate_reset;

  delay #(.INTERVAL(1)) dl_stim (
    .out (dl_stim_out),
    .clk (clk),
    .in  (s1)
    );

  flipflop ff_cu_stim (
    .out     (ff_cs_out),
    .out_bar (), // Unconnected
    .set     (dl_stim_out),
    .reset   (dl_sr_out)
    );

  delay #(.INTERVAL(1)) dl_stim_reset (
    .out (dl_sr_out),
    .clk (clk),
    .in  (coincidence)
    );


  // Logic to gate coincidence for duration starting 
  // from d2 (d20) upto and excluding d7 (d25) pulse occurrence.
  assign cu_window_set   = d2 | d20;
  assign cu_window_reset = d7 | d25;

  flipflop ff_cu_window (
    .out     (cu_window),
    .out_bar (), // Unconnected.
    .set     (cu_window_set),
    .reset   (cu_window_reset)
    );


  assign order_sct = order | sct;
  assign comp_res  = cu_window ? (order_sct ^ cntr) : 1'b0;
  assign dl_cc_in  = d0 | d18;

  delay #(.INTERVAL(1)) dl_cu_comp (
    .out (ff_cc_set),
    .clk (clk),
    .in  (dl_cc_in)
    );

  flipflop ff_cu_comp (
    .out     (ff_cc_out),
    .out_bar (), // Unconnected.
    .set     (ff_cc_set),
    .reset   (comp_res)
     );

  assign coincidence = ff_cs_out & ff_cc_out & dl_cc_in;


  flipflop ff_cu_gate (
    .out     (cu_gate_pos),
    .out_bar (cu_gate_neg),
    .set     (coincidence),
    .reset   (ff_cu_gate_reset)
    );

  delay #(.INTERVAL(1)) dl_cu_gate_reset (
    .out (dl_cgr_out),
    .clk (clk),
    .in  (cu_gate_pos)
    );

  assign ff_cu_gate_reset = (d0 | (f1_neg & d18)) & dl_cgr_out;


  // 1 M/C delay to allow data to move out from the Memory Tank.
/* -----\/----- EXCLUDED -----\/-----
  delay #(.INTERVAL(36)) dl_rpulse (
    .out (dl_rp_out),
    .clk (clk),
    .in  (coincidence)
    );
 -----/\----- EXCLUDED -----/\----- */

endmodule
