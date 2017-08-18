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

  wire clk_d, data_out1, data_out2, data_out3;
  reg [26:0] counter = 0;
  reg data_in;
  reg [1:0] states = 3'b000;

  always @(posedge clk) begin
    counter <= counter + 1'b1;
  end
  assign clk_d = counter[26];

  always @(posedge clk_d) begin
    case (states)
      3'b000: begin
        data_in <= 1'b1;
        states <= 3'b001;
      end
      3'b001: begin
        data_in <= 1'b0;
        states <= 3'b010;
      end
      3'b010: begin
        data_in <= 1'b1;
        states <= 3'b011;
      end
      3'b111: begin
        data_in <= 1'b0;
        states <= 3'b100;
      end
      3'b100: begin
        data_in <= 1'b0;
        states <= 3'b101;
      end
      3'b101: begin
        data_in <= 1'b1;
        states <= 3'b110;
      end
      3'b110: begin
        data_in <= 1'b1;
        states <= 3'b111;
      end
      3'b111: begin
        data_in <= 1'b0;
        states <= 3'b000;
      end
    endcase
  end

  assign PMOD[55:52] = {data_out1, data_out2, data_out3, data_in};

  delay #(.INTERVAL(3)) delay_line1 (
    .out (data_out1), // Every negedge of clock, data_out is pushed out.
    .clk (clk_d), // Slow clock for onboard LED visibility.
    .in  (data_in) // Data taken in every positive edge of clock.
    );

  delay #(.INTERVAL(2)) delay_line2 (
    .out (data_out2), // Every negedge of clock, data_out is pushed out.
    .clk (clk_d), // Slow clock for onboard LED visibility.
    .in  (data_in) // Data taken in every positive edge of clock.
    );

  delay #(.INTERVAL(1)) delay_line3 (
    .out (data_out3), // Every negedge of clock, data_out is pushed out.
    .clk (clk_d), // Slow clock for onboard LED visibility.
    .in  (data_out2) // Data taken in every positive edge of clock.
    );

endmodule
