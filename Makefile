VIMVERNS := github.com/yowcow/vim-ver
LATEST = .latest
BUILD = _build

VERSION ?= $(shell cat .latest)
ARCHIVE = v$(VERSION).tar.gz
UNARCHIVED = vim-$(VERSION)
PREFIX ?= /usr/local/$(UNARCHIVED)

.PHONY: all build install current clean

all: $(LATEST)

$(LATEST):
	which vim-ver || go get -v $(VIMVERNS) && go install -v $(VIMVERNS)
	vim-ver latest > $@

build: $(BUILD)
	cd $< && \
		./configure \
			--prefix=$(PREFIX) \
			--enable-fail-if-missing \
			--enable-luainterp \
			--enable-multibyte \
			--enable-terminal \
			--with-lua-prefix=/usr/local && \
		make

$(BUILD): src/$(ARCHIVE)
	mkdir -p $@
	tar xzf $< -C $@ --strip-components=1

src/$(ARCHIVE): src
	curl -L https://github.com/vim/vim/archive/$(ARCHIVE) -o $@

src:
	mkdir -p $@

install:
	cd $(BUILD) && make install

current:
	-rm /usr/local/vim
	ln -s $(PREFIX) /usr/local/vim

clean:
	rm -rf $(BUILD)
