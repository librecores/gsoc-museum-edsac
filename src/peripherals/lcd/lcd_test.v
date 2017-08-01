`timescale 1 ns / 1 ns

module lcd_test();

    wire       lcd_rs;
    wire       lcd_en;
    wire       lcd_rw;
    wire [7:0] lcd_data;
    reg        clk;
    wire [3:0] debug;

    initial begin
        $dumpfile("lcd_test.vcd");
        $dumpvars(0, lcd_test);
        clk = 1'b0;
        #20000000
        $finish;
    end

    always begin
        #5 clk <= ~clk;
    end

    lcd my_lcd (
        .lcd_rs   (lcd_rs), // 1-bit wide
        .lcd_en   (lcd_en), // 1-bit wide
        .lcd_rw   (lcd_rw), // 1-bit wide
        .lcd_data (lcd_data), // 8-bit wide
        .debug    (debug[3:0]),
        .data     (), // Unconnected, for now.
        .clk      (clk)
    );

endmodule
