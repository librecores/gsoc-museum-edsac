chip.bin: chip.v edsac.v computer.v control_section.v memory_top.v computer/*.v memory/*.v control_section/*.v input/*.v output/*.v misc/*.v blackice.pcf
	yosys -q -p "synth_ice40 -blif chip.blif" chip.v edsac.v computer.v control_section.v memory_top.v computer/*.v memory/*.v control_section/*.v input/*.v output/*.v misc/*.v
	arachne-pnr -d 8k -P tq144:4k -p blackice.pcf chip.blif -o chip.asc
	icepack chip.asc chip.bin

.PHONY: clean
clean:
	$(RM) -f chip.blif chip.asc chip.ex chip.bin
