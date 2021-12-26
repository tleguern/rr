PROG= rr

INSTALL_PROGRAM?= install -m 0555
INSTALL_MAN?= install -m 0444
DESTDIR?=/usr/local/
BINDIR?=bin
MANDIR?=man

.SUFFIXES: .sh .1 .md
.PHONY: clean install

.sh:
	cp $< $@
	chmod +x $@

.1.md:
	mandoc -T markdown $< > $@

${PROG}: ${PROG}.sh

install:
	mkdir -p ${DESTDIR}${BINDIR}
	mkdir -p ${DESTDIR}${MANDIR}/man1
	${INSTALL_PROGRAM} ${PROG} ${DESTDIR}${BINDIR}
	${INSTALL_MAN} ${PROG}.1 ${DESTDIR}${MANDIR}/man1

clean:
	rm -f -- ${PROG}
