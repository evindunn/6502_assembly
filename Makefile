OUTDIR=bin
OUTFILE=${OUTDIR}/hello-world.prg
LABELFILE=${OUTFILE}.label.txt
CFLAGS=-Fbin -wfail -x -dotdir -exec=main -cbm-prg

.PHONY: all clean run dump

all: ${OUTFILE}

clean:
	rm -f ${OUTFILE} ${LABELFILE}

# https://vice-emu.sourceforge.io/
run: ${OUTFILE}
	x64sc ${OUTFILE}

dump: ${OUTFILE}
	hexdump -C ${OUTFILE}

# http://sun.hasenbraten.de/vasm/
${OUTFILE}: hello-world.s
	vasm6502_oldstyle ${CFLAGS} -L ${LABELFILE} -o $@ $^
