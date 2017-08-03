chip.bin: chip.v lcd.v blackice.pcf
	yosys -q -p "synth_ice40 -blif chip.blif" chip.v lcd.v
	arachne-pnr -d 8k -P tq144:4k -p blackice.pcf chip.blif -o chip.txt
	icepack chip.txt chip.bin

.PHONY: clean
clean:
	$(RM) -f chip.blif chip.txt chip.ex chip.bin
