  module chip (
  // SRAM Memory lines
  output wire [18:0] ADR,
  output wire [15:0] DAT,
  output wire        RAMOE,
  output wire        RAMWE,
  output wire        RAMCS,
  // All PMOD outputs
  output wire [55:0] PMOD,

  // 100MHz clock input
  input wire        clk
  );

  // SRAM signals are not use in this design, lets set them to default values
  assign ADR [18:0] = {19{1'b0}};
  assign DAT [15:0] = {16{1'b0}};
  assign RAMOE      = 1'b1;
  assign RAMWE      = 1'b1;
  assign RAMCS      = 1'b1;

  // Set unused pmod pins to default
  assign {PMOD[51:23], PMOD[15:12], PMOD[7:0]} = {41{1'bz}};
  // assign {PMOD[55:23], PMOD[15:12], PMOD[7:0]} = {45{1'bz}};

  lcd my_lcd (
    .lcd_rs   (PMOD[22]), // 1-bit wide
    .lcd_en   (PMOD[21]), // 1-bit wide
    .lcd_rw   (PMOD[20]), // 1-bit wide
    .lcd_data ({PMOD[19:16], PMOD[11:8]}), // 8-bit wide
    .debug    (PMOD[55:52]),
    .data     (), // Unconnected, for now.
    .clk      (clk)
    );

endmodule
