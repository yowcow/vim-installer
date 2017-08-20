.PHONY: clean

DARWINBIN := vim-version-darwin
LINUXBIN := vim-version-linux

all: bin bin/$(DARWINBIN) bin/$(LINUXBIN)

bin:
	mkdir -p bin

bin/$(DARWINBIN):
	GOOS=darwin GOARCH=amd64 go build -o bin/$(DARWINBIN)

bin/$(LINUXBIN):
	GOOS=linux GOARCH=amd64 go build -o bin/$(LINUXBIN)

clean:
	rm -rf bin/*
