  module chip (
  // SRAM Memory lines
  output wire [18:0] ADR,
  output wire [15:0] DAT,
  output wire        RAMOE,
  output wire        RAMWE,
  output wire        RAMCS,
  // All PMOD outputs
  // {PMOD[16], PMOD[11:8]} reused for Control Switches.
  output wire [55:0] PMOD,

  // Assign external buttons for Control Switches module.
  // Using GPIO PMOD 3 and 5 with push buttons.
  input wire         resume_btn, // PMOD[8]
  input wire         single_ep_btn, // PMOD[9]
  input wire         start_btn, // PMOD[10]
  input wire         stop_btn, // PMOD[11]
  input wire         extended_btn, // PMOD[16]

  // myStorm board has negative button logic, i.e., BUT is LOW when pressed.
  input wire [1:0]   BUT,
  // 100MHz clock input
  input wire         clk
  );

  // SRAM signals are not use in this design, lets set them to default values
  assign ADR [18:0] = {19{1'b0}};
  assign DAT [15:0] = {16{1'b0}};
  assign RAMOE      = 1'b1;
  assign RAMWE      = 1'b1;
  assign RAMCS      = 1'b1;

  // Set unused pmod pins to default
  // PMOD[55] is LED1 on board, PMOD[54] is LED2, and so on.
  assign PMOD[55:0] = {56{1'bz}};

  // EDSAC ran at a clock of 500KHz.
  reg [7:0] count = 0;
  reg clk_edsac   = 0;

  always @(posedge clk) begin
    count[7:0] <= count[7:0] + 1;
    if (count[7:0] == 8'b1100_1000) begin
      clk_edsac <= ~clk_edsac;
      count[7:0] <= 0;
    end
  end

  edsac edsac (
    .clk           (clk_edsac),
    .resume_btn    (resume_btn),
    .single_ep_btn (single_ep_btn),
    .start_btn     (start_btn),
    .stop_btn      (stop_btn),
    .extended_btn  (extended_btn)
    );

endmodule
