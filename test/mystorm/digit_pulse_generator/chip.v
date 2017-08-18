module chip (
  // SRAM Memory lines
  output wire [18:0] ADR,
  output wire [15:0] DAT,
  output wire        RAMOE,
  output wire        RAMWE,
  output wire        RAMCS,
  // All PMOD outputs
  output wire [55:0] PMOD,

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
  assign PMOD[51:0] = {52{1'bz}};

  wire clk_d;
  reg [26:0] counter = 0;
  wire [35:0] digit_pulse;

  always @(posedge clk) begin
    counter <= counter + 1'b1;
  end
  assign clk_d = counter[26];

  assign PMOD[55:52] = {clk_d, digit_pulse[3], digit_pulse[0], digit_pulse[1]};

  digit_pulse_generator dpg (
    .digit_pulse (digit_pulse[35:0]),
    .clk         (clk_d) // Slow clock for onboard LED visibility.
    );

endmodule
