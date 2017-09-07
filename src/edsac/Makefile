# Copyright 2017 Hatim Kanchwala

# Contributor Hatim Kanchwala <hatim@hatimak.me>

# This documentation describes Open Hardware and is licensed under the
# CERN OHL v. 1.2.

# You may redistribute and modify this documentation under the terms of the
# CERN OHL v.1.2. (http://ohwr.org/cernohl). This documentation is distributed
# WITHOUT ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING OF MERCHANTABILITY,
# SATISFACTORY QUALITY AND FITNESS FOR A PARTICULAR PURPOSE. Please see the
# CERN OHL v.1.2 for applicable conditions

TOP = chip

SRCS = $(TOP).v            \
       edsac.v             \
       computer.v          \
       control_section.v   \
       memory_top.v        \
       computer/*.v        \
       memory/*.v          \
       control_section/*.v \
       input/*.v           \
       output/*.v          \
       misc/*.v

PCF = blackice.pcf

$(TOP).bin: $(TOP).asc
	icepack $^ $@

$(TOP).asc: $(TOP).blif $(PCF)
	arachne-pnr -d 8k -P tq144:4k -p $(PCF) $(TOP).blif -o $@

$(TOP).blif: $(SRCS)
	yosys -q -p "synth_ice40 -blif $(TOP).blif" $^

# Upload to Linux, may have to change name of the port accordingly

.PHONY: upload-linux
upload-linux:
	cat $(SERIAL) > /dev/null 2>&1 &
	stty -F $(SERIAL) raw
	cat chip.bin > $(SERIAL)
	ps x | grep "cat $(SERIAL)" | head -1 | \
	       sed -e 's/\([[:digit:]]*\) .*$$/now run "kill \1"/'

# Icarus Verilog simulation

$(TOP).vvp: $(SRCS)
	iverilog -o $@ $(SRCS)

.PHONY: clean
clean:
	$(RM) -f $(TOP).blif $(TOP).asc $(TOP).ex $(TOP).bin $(TOP).vvp
