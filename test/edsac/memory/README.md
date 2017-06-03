## delay_line_tb
```bash
iverilog -o delay_line delay_line_tb.v ../../../src/edsac/memory/delay_line.v && vvp delay_line && gtkwave delay_line.vcd &
```
