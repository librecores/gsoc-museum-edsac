## Instruction Set

|    |  Order   | Binary Code   | Short Description |
|---:|:---------|:-------------:|:------------------|
|  1 | A n      |     11100     | Add number in memory position `n` into Accumulator
|  2 | S n      |     01100     | Subtract number in memory position `n` from Accumulator
|  3 | H n (M)  |     10101     | Transfer from memory position `n` into Multiplier
|  4 | C n      |     11110     | Collate number in memory position `m` with Multiplier and add result into Accumulator
|  5 | V n (N)  |     11111     | Multiply number in memory position `m` with Multiplier and add result into Accumulator
|  6 | N n (N') |     10110     | Multiply number in memory position `m` with Multiplier and subtract result from Accumulator
|  7 | T n      |     00101     | Transfer from Accumulator to memory position `n` and clear Accumulator
|  8 | U n (T') |     00111     | Transfer from Accumulator to memory position `n` without clearing Accumulator
|  9 | I n      |     01000     | Read next row of holes on Input Tape and put in least significant 5 bits ofmemory position `n`
| 10 | O n      |     01001     | Print character represented by most significant 5 bits of number in memory position 'n'
| 11 | E n (D)  |     00011     | If Accumulator is positivev(>= 0), jump to memory location `n`, otherwise proceed serially
| 12 | G n (-)  |     11011     | If Accumulator is negative, jump to memory location `n`, otherwise proceed serially
| 13 | R n      |     00100     | Shift contents of Accumulator `n` places to the right (1 <= n <= 10)
| 14 | L n      |     11001     | Shift contents of Accumulator `n` places to the left (1 <= n <= 10)
| 15 | Y (Z1)   |     00110     | Round off number to 34 binary digits
| 16 | - (Z2)*  |               | Round off number to 16 binary digits
| 17 | Z (Z3)   |     01101     | Stop machine and rin alarm
| 18 | X (-)*   |     11010     | No operation
| 19 | F n (-)* |     10001     | Read the last character output for verification

- Codes corresponding to Orders are not specified in the original report by Wilkes.
- The Tutorial Guide for Prof. Martin Campbell-Kelly's EDSAC simulator says the binary representation of the order is the same as the character code of the corresponding character.
- Prof. Martin Campbell-Kelly's Tutorial Guide and Article describe 18 orders whereas the original report by Wilkes describes only 16 (*). For some orders, the character codes are also different. Wherever different, original report's order is noted in parentheses in the Order column above.
- There was no unconditional branch order originally, but was added in 1952.
- Shift order is given by the *position* of the rightmost bit in the instruction word, instead of the *value* of the address field of the instruction - 2^(n-2).
