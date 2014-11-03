.PHONY: all install uninstall

SRC := dis

all:
install:
	install -D -c $(SRC) $(prefix)/bin
uninstall:
	rm $(foreach s,$(SRC),$(prefix)/bin/$s)
