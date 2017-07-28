/* To send command:
 *     RS is low
 *     RW is high
 *     command opcode is driven on DB0-7
 *     EN is negative going pulse
 *
 * To send data:
 *     RS is high
 *     RW is high
 *     data is driven on DB0-7
 *     EN is negative going pulse
 */

module lcd (
    output reg       lcd_rs, // Register select: HIGH for DATA register, LOW for COMMAND register.
    output reg       lcd_en, // HIGH to LOW, negative edge.
    output reg       lcd_rw, // Read/write: HIGH for read, LOW for write.
    output reg [7:0] lcd_data, // Pins DB7 to DB0.

    output wire [3:0] debug,

    input wire [7:0] data,
    input wire       clk
    );

    parameter lcd_cmd_function_set = 10'b00_0011_1000; // 8-bit bus 2-line display mode, 5x8 dots format.
    parameter lcd_cmd_disp_conf    = 10'b00_0000_1110; // Display ON, cursor ON, cursor blink OFF.
    parameter lcd_cmd_clear        = 10'b00_0000_0001; // Clear display.
    parameter lcd_cmd_inc_cur      = 10'b00_0000_0110; // Increment cursor.
    parameter lcd_cmd_cur_l1p1     = 10'b00_1000_0000; // Cursor at line 1, position 1.
    parameter lcd_cmd_ret_home     = 10'b00_0000_0010; // Return home.
    parameter lcd_cmd_shift_disp_r = 10'b00_0001_1100; // Shift entire display right.

    // INTERNAL CONTROL SIGNALS
    /* Whether the LCD is busy with internal operation. DB7 can be queried with RS=0, RW=1. 
     * If DB7=1, internal operation under process, else if DB7=0, NOT under process.
     */

    /*    9    8    7     6           1     0
     *  ---------------------------------------
     * | RS | RW | DB7 | DB6 | ... | DB1 | DB0 |
     *  ---------------------------------------
     */

    wire clk_d1;
    reg  cd1_on;
    wire clk_d2;
    reg  cd2_on;
    reg en;

    clock_divider #(.WIDTH(18)) cd1 (
        .clk_d (clk_d1),
        .on    (cd1_on),
        .clk   (clk)
        );

    clock_divider #(.WIDTH(8)) cd2 (
        .clk_d (clk_d2),
        .on    (cd2_on),
        .clk   (clk)
        );

    reg [2:0] states;

    initial begin
        cd1_on = 1'b1;
        cd2_on = 1'b1;
        states = 3'b000;
        {lcd_rs, lcd_rw, lcd_data} = {10{1'bz}};
        lcd_en = 1'b0;
        en = 1'b0;
    end

    assign debug[3:0] = {states[2:0], en};

    always @(posedge clk_d2) begin
        if (en) begin
            lcd_en <= 1'b1;
        end
    end
    always @(negedge clk_d2) begin
        if (en) begin
            lcd_en <= 1'b0;
            en <= 1'b0;
        end
    end

    always @(posedge clk_d1) begin
        case (states)
            3'b000: begin
                en <= 1'b1;
                {lcd_rs, lcd_rw, lcd_data} <= 10'b00_0011_1000; // 8-bit bus 2-line display mode, 5x8 dots format.
                states <= 3'b001;
            end
            3'b001: begin
                en <= 1'b1;
                {lcd_rs, lcd_rw, lcd_data} <= 10'b00_0000_0001; // Clear display.
                states <= 3'b010;
            end
            3'b010: begin
                en <= 1'b1;
                {lcd_rs, lcd_rw, lcd_data} <= 10'b00_0000_1110; // Display ON, cursor ON, cursor blink OFF.
                states <= 3'b011;
            end
            3'b011: begin
                en <= 1'b1;
                {lcd_rs, lcd_rw, lcd_data} <= 10'b10_0100_0001;
                states <= 3'b100;
            end
            3'b100: begin
                en <= 1'b1;
                {lcd_rs, lcd_rw, lcd_data} <= 10'b10_0100_0011;
                states <= 3'b101;
            end
            3'b101: begin
                en <= 1'b1;
                {lcd_rs, lcd_rw, lcd_data} <= 10'b10_0100_0011;
                states <= 3'b110;
            end
            3'b110: begin
                en <= 1'b0;
                {lcd_rs, lcd_rw, lcd_data} <= 10'b00_0000_0000;
                states <= 3'b110;
            end
        endcase
    end

endmodule

/* Counts as long as `on` is high. Positive edge 
 * of `done` signifies count is complete.
 */
module clock_divider #(
    parameter WIDTH = 15
    ) (
    output wire clk_d,
    input wire  on,
    input wire  clk
    );

    reg [WIDTH-1:0] count;

    initial begin
        count = 0;
    end

    always @(posedge clk) begin
        count <= on ? (count + 1'b1) : 0;
    end

    assign clk_d = count[WIDTH-1];

endmodule
