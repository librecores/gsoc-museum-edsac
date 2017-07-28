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

endmodule
