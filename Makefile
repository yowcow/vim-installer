VIM_VER := github.com/yowcow/vim-ver
CURRENT_VERSION = .current-version
SRC = _src
BUILD = _build

VERSION ?= $(shell cat $(CURRENT_VERSION))
PREFIX ?= $(shell pwd)/versions/$(VERSION)

.PHONY: all build install current clean realclean

all: $(CURRENT_VERSION)

$(CURRENT_VERSION):
	which vim-ver || go get -v $(VIM_VER) && go install -v $(VIM_VER)
	vim-ver HEAD > $@
	cat $@

build: $(BUILD)
	cd $< && \
		./configure --prefix=$(PREFIX) $(shell cat configure-options) && \
		make

$(BUILD): $(SRC)/v$(VERSION).tar.gz
	mkdir -p $@
	tar xzf $< -C $@ --strip-components=1

$(SRC)/%.tar.gz: $(SRC)
	curl -L https://github.com/vim/vim/archive/$(notdir $@) -o $@

$(SRC):
	mkdir -p $@

install: $(PREFIX)

$(PREFIX):
	cd $(BUILD) && make install

current: $(PREFIX)
	rm -f current
	ln -s $(PREFIX) current

clean:
	rm -rf $(BUILD) $(CURRENT_VERSION)

realclean: clean
	rm -rf $(SRC)
