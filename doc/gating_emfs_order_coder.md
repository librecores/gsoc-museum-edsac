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
