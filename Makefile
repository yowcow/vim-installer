UNAME := $(shell uname -s)

ifeq ($(UNAME),Linux)
    VERSION ?= $(shell ./bin/vim-version-linux)
endif
ifeq ($(UNAME),Darwin)
    VERSION ?= $(shell ./bin/vim-version-darwin)
endif

ARCHIVE = v$(VERSION).tar.gz
UNARCHIVED = vim-$(VERSION)
PREFIX = /usr/local/$(UNARCHIVED)

.PHONY: all install current

all: $(UNARCHIVED)
	cd $< && \
		./configure \
			--prefix=$(PREFIX) \
			--enable-fail-if-missing \
			--enable-luainterp \
			--enable-multibyte \
			--enable-terminal \
			--with-lua-prefix=/usr/local && \
		make

install:
	cd $(UNARCHIVED) && \
		make install

current:
	-rm /usr/local/vim
	ln -s $(PREFIX) /usr/local/vim

$(ARCHIVE):
	curl -LO https://github.com/vim/vim/archive/$(ARCHIVE)

$(UNARCHIVED): $(ARCHIVE)
	tar xzf $<
