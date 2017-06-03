## delay_line_tb
```bash
iverilog -o delay_line_uut.out delay_line_tb.v ../../../src/edsac/memory/delay_line.v && vvp delay_line_uut.out && gtkwave delay_line.vcd &
```

-----

## memory_tb
```bash
iverilog -o mem_uut.out memory_tb.v ../../../src/edsac/memory/memory.v ../../../src/edsac/memory/delay_line.v && vvp mem_uut.out && gtkwave mem_uut.out &
```
