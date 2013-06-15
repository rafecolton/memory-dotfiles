test:
	$$PWD/run-tests

install:
	$$PWD/scripts/install

uninstall:
	mdf uninstall

.PHONY: test install uninstall
