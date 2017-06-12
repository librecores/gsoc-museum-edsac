## ccu_1_tb
```bash
iverilog -o ccu_1_uut.out ccu_1_tb.v ../../../src/edsac/control_section/ccu_1.v ../../../src/edsac/memory/delay.v ../../../src/edsac/misc/flipflop.v ../../../src/edsac/memory/delay_line.v ../../../src/edsac/misc/digit_pulse_generator.v && vvp ccu_1_uut.out && gtkwave ccu_1.vcd &
```
