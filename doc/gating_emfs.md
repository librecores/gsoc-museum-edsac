## Gating EMFs emitted by Order Coder

|    | EMFs | Orders |
|---:|:-----|:-------|
|  1 | C1   | A, S, C, V, N
|  2 | C2   | A
|  3 | C3   | S
|  4 | C4   | C
|  5 | C5   | V, N
|  6 | C6   | R, L
|  7 | C7   | R
|  8 | C8   | L
|  9 | C9   | X, Y
| 10 | C10  | G
| 11 | C11  | N
| 12 | C12  | X
| 13 | C13  | Y
| 14 | C14  | V
| 15 | C16  | I
| 16 | C17  | T, U, I, F
| 17 | C17A | 
| 18 | C18  | H
| 19 | C19  | T, U
| 20 | C20  | T
| 21 | C21  | O
| 22 | C22  | Z, Illegal Orders
| 23 | C24  | C, H
| 24 | C25  | E
| 25 | C26  | A, S, C, V, N, H
| 26 | C27  | I, O

- C15 and C23 are mentioned in the original report by Wilkes that weren't used at the time.
- To compute the gating EMFs, the Order Coder takes as input other opcodes also in addition to the ones listed above.

-----

## Gating EMFs emitted in MCU/CCUs

|    |  EMFs    | Produced in  | Purpose |
|---:|:---------|:------------:|:--------|
|  1 | g1 (+/-) | CCU 1        | Minor cycle gate from Accumulators 1 and 2 (even/odd)
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
