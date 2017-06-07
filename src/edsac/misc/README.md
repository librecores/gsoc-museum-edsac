## digit_pulse_generator_tb
```bash
iverilog -o dpg.out digit_pulse_generator_tb.v ../../../src/edsac/misc/digit_pulse_generator.v ../../../src/edsac/memory/delay.v ../../../src/edsac/memory/delay_line.v && vvp dpg.out && gtkwave digit_pulse_generator.vcd &
```
