## adder_tb
```bash
iverilog -o adder_uut.out adder_tb.v ../../../src/edsac/computer/adder.v ../../../src/edsac/computer/half_adder.v ../../../src/edsac/memory/delay.v ../../../src/edsac/memory/delay_line.v  && vvp adder_uut.out && gtkwave adder.vcd &
```
