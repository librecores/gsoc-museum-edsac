chip.bin: chip.v ../../../src/edsac/misc/flipflop.v blackice.pcf
	yosys -q -p "synth_ice40 -blif chip.blif" chip.v ../../../src/edsac/misc/flipflop.v
	arachne-pnr -d 8k -P tq144:4k -p blackice.pcf chip.blif -o chip.asc
	icepack chip.asc chip.bin

.PHONY: clean
clean:
	$(RM) -f chip.blif chip.asc chip.ex chip.bin
