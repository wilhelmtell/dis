.PHONY: all install uninstall

SRC := dis

all:
install:
	mkdir -p $(prefix)/bin
	install -D -c $(SRC) $(prefix)/bin
uninstall:
	rm $(foreach s,$(SRC),$(prefix)/bin/$s)
