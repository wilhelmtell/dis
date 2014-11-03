prefix ?= /usr/local

.PHONY: all clean distclean install uninstall dist

all:
	${MAKE} --directory lib all
	${MAKE} --directory bin all
clean:
	@echo nothing to clean
distclean: clean
install:
	${MAKE} --directory lib install
	${MAKE} --directory bin install
uninstall:
	${MAKE} --directory bin uninstall
	${MAKE} --directory lib uninstall
dist:
	git archive --prefix=dis/ master |xz -9 >dis.tar.xz
