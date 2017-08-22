Vim Installer
=============

A small set of tools to install the latest Vim to `/usr/local/vim-#{version}`

HOW TO USE
----------

Clone this repository into somewhere.

To install the latest vim, do:

```
make && make build && sudo make install
```

To make the latest vim a current version, do:

```
sudo make current
```

To clean up the previous build, do:

```
make clean
```
