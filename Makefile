test:
	$(PWD)/spec/run

install:
	$(PWD)/scripts/install

uninstall:
	mdf uninstall

.PHONY: test install
