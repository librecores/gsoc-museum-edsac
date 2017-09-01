/* Module for Control Switches Unit.
 *
 * TODO: Logic descriptin had a CLS- (cls_neg)
 *       signal but since it's purpose is not
 *       clearly understood it is not included here.
 */

module contol_switches (
  output wire epsep,
  output wire ep11,
  output wire extended_pos,
  output wire extended_neg,
  output wire single_ep,
  output wire start,
  output wire stop_neg,

  input wire  s2,
  input wire  c22,
  input wire  d18,
  input wire  d35,
  input wire  ep,
  input wire  starter_neg,
  input wire  sep2,
  input wire  resume_btn, // Pulse button.
  input wire  single_ep_btn, // Pulse button.
  input wire  start_btn, // Pulse button.
  input wire  stop_btn, // Pulse button.
  input wire  extended_btn, // Toggle button (but physical connection to pulse button).
  input wire  clk
  );

  reg  extended_t = 0;
  wire ff1_reset;
  wire ff1_set;
  wire ff2_set;
  wire ff3_set;
  wire ff1_outbar;
  wire ff2_out;
  wire ff3_out;

  wire dl_out; // Added by Dan

  assign single_ep = resume_btn | single_ep_btn | sep2;
  assign epsep = ep | single_ep;

  always @(posedge extended_btn) begin
    extended_t <= ~extended_t;
  end

  assign extended_pos = extended_t;
  assign extended_neg = ~extended_pos;
  assign ff1_set = ff2_set | stop_btn;
  assign ff2_set = starter_neg | c22 | s2;
  assign ff1_reset = start_btn | resume_btn;
  assign ff3_set = d18 & ff2_out;

  assign stop_neg = starter_neg | ff1_outbar;
  assign start = start_btn;
  assign ep11 = d35 & ff3_out;

  flipflop ff1 (
    .out     (), // Unconnected.
    .out_bar (ff1_outbar),
    .set     (ff1_set),
    .reset   (ff1_reset)
    );

  flipflop ff2 (
    .out     (ff2_out),
    .out_bar (), // Unconnected.
    .set     (ff2_set),
    .reset   (dl_out)
    );

  flipflop ff3 (
    .out     (ff3_out),
    .out_bar (), // Unconnected.
    .set     (ff3_set),
    .reset   (dl_out)
    );

  delay #(.INTERVAL(1)) dl (
    .out (dl_out),
    .clk (clk),
    .in  (ep11)
    );

endmodule
