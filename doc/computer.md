## Computer

- Carries out all arithmetic operations, plays role befitting a modern ALU.
- Comprises separate units for addition, complementing, collating, shifting and multiplying.
- Operations supervised by CCU (CCU is what MCU is to Control Section).

-----

### Accumulator
- Consists of two tanks providing total 2 M/C - 4 p.i. delay,
    - Accumulator I of 1 M/C delay, and
    - Accumulator II of (1 M/C - 4 p.i.) delay.

-----

### Accumulator Shifting Unit
- When number is just circulating, provides 2 p.i. delay (no shifting - G5 is low, irrespective of C6, C7, C8).

#### ASU I
- Used for extraction of numbers from the Accumulator.
    - Output from both Accumulator Tanks provided as input.
- Serves to provide gating EMFs to ASU II (X1, X2, X3 and X4).

#### ASU II
- Actual shifting operation
    - Right shift, only 1 p.i. delay, so total Computer delay is 2 M/C - 1 p.i.
    - Left shift, 3 p.i. delay in ASU II (1 p.i. in addition to normal), so total Computer delay is 2 M/C + 1 p.i.

-----

#### Adder
- Provides 2 p.i. delay
- Comprises two Half Adders
    - 1 p.i. delay in respective sum output
    - 2 p.i. delay in respective carry output
