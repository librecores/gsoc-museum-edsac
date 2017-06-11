## Gating EMFs emitted by Order Coder

|    | EMF    | Orders |
|---:|:-------|:-------|
|  1 | `c1`   | A, S, C, V, N
|  2 | `c2`   | A
|  3 | `c3`   | S
|  4 | `c4`   | C
|  5 | `c5`   | V, N
|  6 | `c6`   | R, L
|  7 | `c7`   | R
|  8 | `c8`   | L
|  9 | `c9`   | X, Y
| 10 | `c10`  | G
| 11 | `c11`  | N
| 12 | `c12`  | X
| 13 | `c13`  | Y
| 14 | `c14`  | V
| 15 | `c16`  | I
| 16 | `c17`  | T, U, I, F
| 17 | `c17a` | *not used*
| 18 | `c18`  | H
| 19 | `c19`  | T, U
| 20 | `c20`  | T
| 21 | `c21`  | O
| 22 | `c22`  | Z, Illegal Orders
| 23 | `c24`  | C, H
| 24 | `c25`  | E
| 25 | `c26`  | A, S, C, V, N, H
| 26 | `c27`  | I, O

- `c15` and `c23` are mentioned in the original report by Wilkes that weren't used at the time.
- To compute the gating EMFs, the Order Coder takes as input other opcodes also in addition to the ones listed above.

-----

## Gating EMFs emitted in MCU/CCUs

|    |  EMF     | Produced in  | Purpose |
|---:|:---------|:------------:|:--------|
|  1 | g1 (+/-) | CCU 1        | Odd (+) or even (-) cycles gate.
|  2 | g2 (+/-) | TCTSU        | Multiplicand and shifting gate
|  3 | g3 (+)   | CCU 7        | Multiplicand output
|  4 | g4 (+/-) | CCU 8        | Complementer gate
|  5 | g5       | CCU 3        | Accumulator shifting gate
|  6 | g6 (+)   | CCU 4        | Multiplicand shift for A, S, C orders
|  7 | g7       | Accumulator Warning Unit | Warning gate
|  8 | g8       | CCU 2        | TCT clear gate (Inhibit add/subtract logic in CCU4 ?)
|  9 | g9 (-)   | CCU 9 and 11 | Accumulator clear gate
| 10 | g10 (-)  | CCU 9 and 11 | Multiplier clear gate
| 11 | g11 (-)  | CCU 9 and 11 | Multiplicand clear gate
| 12 | g12      | MCU          | Stage 1 of main control
| 13 | g13      | MCU          | Stage 2 of main control

-----

## Pulse emitted in CCU/TCT

|    | Pulse  | Produced in  | Repsonse pulse | Purpose |
|---:|:-------|:------------:|:---------------|:--------|
|  1 | `dv`     | CCU 10       | `dv_d`          | Sign test pulse for E-order
|  2 | `dv_d`  | Accumulator  |                | Jump condition satisfied
|  3 | `da`     | TCT          |                | Sign test pulse for Multiplicand (via CCU 2)
|  4 | `da_m`  | CCU 2        |                | Sign test pulse for Multiplicand
|  5 | `da_n`  | Multiplicand |                | Result of test Multiplicand sign
|  6 | `ds`     | CCU 2        | `ds_r`          | Sign test for right shifts
|  7 | `ds_r`  | Accumulator  |                | Sign bit propagation for right shifts
|  8 | `dr`     |              |                | *TODO*
|  9 | `dw`     |              |                | *TODO*
| 10 | `dx`     | TCT          | `dx_m`          | Digit test pulse for multiplier
| 11 | `dx_m`  | Multiplier   |                | Response to digit test pulse for multiplier
| 12 | `dy`     | TCT          |                | Resetting pulse after addition of partial product
| 13 | `dz`     |              |                | Suppression pulse, occuring at even D0 (*TODO*)
| 14 | `s1`     |              |                | Stimulating pulse to CU
| 15 | `s2`     |              |                | Stimulating pulse to Computer
| 16 | `r_pulse`     |              |                | Coincidence detected pulse
| 17 | `r2`     |              |                | Coincidence detected to Computer
