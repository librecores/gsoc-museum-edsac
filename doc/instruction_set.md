## Instruction Set

|    | Order    | Code | Short Description |
|---:|:--------:|:----:|:------------------|
|  1 | A n      |      | Add number in memory position `n` into Accumulator
|  2 | S n      |      | Subtract number in memory position `n` from Accumulator
|  4 | H n (M)  |      | Transfer from memory position `n` into Multiplier
|  5 | C n      |      | Collate number in memory position `m` with Multiplier and add result into Accumulator
|  6 | V n (N)  |      | Multiply number in memory position `m` with Multiplier and add result into Accumulator
|  7 | N n (N') |      | Multiply number in memory position `m` with Multiplier and subtract result from Accumulator
|  8 | T n      |      | Transfer from Accumulator to memory position `n` and clear Accumulator
|  9 | U n (T') |      | Transfer from Accumulator to memory position `n` without clearing Accumulator
| 10 | I n      |      | Read next row of holes on Input Tape and put in least significant 5 bits ofmemory position `n`
| 11 | O n      |      | Print character represented by most significant 5 bits of number in memory position 'n'
| 12 | E n (D)  |      | If Accumulator is positive, jump to memory location `n`, otherwise proceed serially
| 13 | G n (-)  |      | If Accumulator is negative, jump to memory location `n`, otherwise proceed serially
| 14 | R n      |      | Shift contents of Accumulator `n` places to the right (1 <= n <= 10)
| 15 | L n      |      | Shift contents of Accumulator `n` places to the left (1 <= n <= 10)
| 16 | Y (Z1)   |      | Round off number to 34 binary digits
| 17 | - (Z2)*  |      | Round off number to 16 binary digits
| 18 | Z (Z3)   |      | Stop machine and rin alarm
| 19 | X (-)*   |      | No operation

- Codes corresponding to Orders are not specified in the original report by Wilkes.
- The Tutorial Guide for Prof. Martin Campbell-Kelly's EDSAC simulator says the binary representation of the order is the same as the character code of the corresponding character.
- Prof. Martin Campbell-Kelly's Tutorial Guide and Article describe 18 orders whereas the original report by Wilkes describes only 16 (*). For some orders, the character codes are also different. Wherever different, original report's order is noted in parentheses in the Order column above.
- There was no unconditional branch order originally, but was added in 1952.
- Shift order is given by the *position* of the rightmost bit in the instruction word, instead of the *value* of the address field of the instruction - 2^(n-2).
