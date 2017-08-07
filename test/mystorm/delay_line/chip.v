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

    wire [2:0] monitor;
    wire clk_d, data_out;
    reg [26:0] counter = 0;
    reg data_clr = 1'b1, data_in_gate = 1'b1, data_in;
    reg [1:0] states = 2'b00;

    always @(posedge clk) begin
        counter <= counter + 1'b1;
    end
    assign clk_d = counter[26];

    always @(posedge clk_d) begin
        if (data_in_gate) begin
            case (states)
                2'b00: begin
                    data_in <= 1'b1;
                    states <= 2'b01;
                end
                2'b01: begin
                    data_in <= 1'b1;
                    states <= 2'b10;
                end
                2'b10: begin
                    data_in <= 1'b0;
                    states <= 2'b11;
                end
                2'b11: begin
                    data_in <= 1'b1;
                    data_in_gate <= 1'b0;
                    states <= 2'b00;
                end
            endcase
        end
    end

    assign PMOD[55:52] = {monitor[0], monitor[1], monitor[2], data_in_gate};

    delay_line #(.STORE_LEN(1), .WORD_WIDTH(3)) delay_line (
        .monitor      (monitor[2:0]),
        .data_out     (data_out), // Every negedge of clock, data_out is pushed out.

        .clk          (clk_d), // Slow clock for onboard LED visibility.
        .data_in      (data_in), // Every positive edge of clock, data_in is read.
        .data_in_gate (data_in_gate),
        .data_clr     (data_clr) // Active low
    );

endmodule
