# Project Abstract

Electronic Delay Storage Automatic Calculator (EDSAC) is a first generation British computer commissioned in 1949. It was built by Maurice Wilkes and his team at the University of Cambridge Mathematical Laboratory. EDSAC is the world’s first stored-program computer.

The project’s goal is to reimagine the EDSAC on modern hardware, with the ultimate objective to make the historic computer accessible to and reproducible by a new generation of computer architects and engineers. Investigating the evolution of computing techniques gives architects and engineers context to modern concepts of computer architecture, organisation and design.

The historic computer, complete with all its subsystems, will be replicated on an FPGA, using Verilog HDL, capable of accepting and executing all EDSAC Orders. To emulate the ancient I/O, various “I/O flavours” will be designed to interface with the FPGA board, via a standardised communication protocol. Users can choose, extend and even add new I/O flavours. An assembler utility will be built in Python, which users can utilise to debug and build their code for EDSAC, which can be then loaded onto the FPGA for execution.

Follow blog posts at <https://hatimak.me/tags/#gsoc>.

