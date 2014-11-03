.PHONY: all clean distclean install uninstall dist

SRC := dis dis.sh error.sh verify.sh

all:
clean:
	@echo nothing to clean
distclean: clean
install:
	install -D -c $(SRC) $(prefix)/bin
uninstall:
	rm $(foreach s,$(SRC),$(prefix)/$s)
	rmdir -p $(prefix)/bin
dist:
	git archive --prefix=dis/ master |xz -9 >dis.tar.xz
