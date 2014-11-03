.PHONY: all install uninstall

SRC := dis.sh error.sh verify.sh

all:
install:
	mkdir -p $(prefix)/lib
	install -D -c $(SRC) $(prefix)/lib
uninstall:
	rm $(foreach s,$(SRC),$(prefix)/lib/$s)
