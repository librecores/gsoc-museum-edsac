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

  wire out, out_bar, set, reset;
  assign PMOD[55:52] = {{2{out}}, {2{out_bar}}};
  // myStorm board has negative button logic, i.e., BUT is LOW when pressed.
  assign set = ~BUT[0];
  assign reset = ~BUT[1];

  flipflop flipflop (
    .out     (out),
    .out_bar (out_bar),
    .set     (set), // Positive edge triggered.
    .reset   (reset) // Positive edge triggered.
    );

endmodule
