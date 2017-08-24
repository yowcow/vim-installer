Vim Installer
=============

A small set of tools to install the latest Vim to `/usr/local/vim-#{version}`

HOW TO USE
----------

Clone this repository into somewhere.

To build the latest vim into directory `versions`, do:

```
make && make build && make install
```

To make a symlink to currently current Vim, do:

```
make current
```

To clean up the previous build, do:

```
make clean
```

To clean up downloaded Vim source tarballs, do:

```
make realclean
```

MODIFYING CONFIGURE OPTIONS
---------------------------

Modify options in file `configure-options`.

USING INSTALLED VIM
-------------------

Add `<path/to/this/repository>/current/bin` to environment variable `$PATH`.

REMOVING OLD VIM VERSIONS
-------------------------

Clean things in directory `versions`.
Make sure symlink `current` does not point to deleting directory.
