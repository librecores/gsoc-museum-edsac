## Main Control Unit

- Controls sequencing of instructions.
- Provides control signals.
- Operates in two stages, which in modern computer architecture terms is,
    - "Instruction fetch" (Stage 1), and 
    - "Execution" (Stage 2).

### Stage 1
- Once `ep` (or `single_ep`) is received, G12 is emitted to provide routes from,
    - SCT to CU, Tank Number and Half-cycle Flashing Units, and
    - Order Tank to MOB.
- Once Stage I has started and is running, the next `d0` causes stimulating pulse `s1` to be emitted to CU. CU searches for next instruction at address determined by SCT. When instruction has been found and transferred to Order Tank, `r_pulse` is emitted by CU. This resets G12 (Stage I concludes) and sets G13 (Stage II commences).
- Lowering `stop_neg` halts operation, and prevents triggering of another Stage I.

### Stage 2
- Once `r_pulse` is received, G13 is emitted,
    - to provide route from Order Tank to CU and all Flashing Units, and
    - stimulating signal `r2` is sent to Computer.
- Emits stimulating pulse to Computer (and to CU wherever required).
- Emits gating EMF connecting Order Tank to SCT in case of sign pulse following CTO.
