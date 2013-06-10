memory-dotfiles
===============

[![Build Status](https://travis-ci.org/rafecolton/memory-dotfiles.png?branch=master)]
(https://travis-ci.org/rafecolton/memory-dotfiles)

## About

### General

    Making your dotfiles more accessible and less obtrusive
    
The idea behind memory-dotfiles is to provide both some nice standard 
dotfiles and also an easy way to sub them in and out on any given system.
Essentially, a person should be able to use a system the way they'd like
for a while and then put it back how it was when they found it.

This process should be:

* unobtrusive
* flexible
* safe
* self-contained
* a good citizen (clean up after itself)
* easy
* simple

It is still just an idea, so we'll see how it goes.

### Gotchas

:boom: **NOTE: Use with caution.  This is still a WIP, so using it may
screw some things up in your `$HOME` directory.** :boom: 

If you screw something up and cannot fix it, submit a GitHub Issue and I will
do my best to help you fix it.

In addition to this being a WIP, there is one small gotcha with symlinks. For
any of the files in your dotfiles, if the file in your `$HOME` directory you
intend for it to replace is a symlink, it is likely that you will lose the
contents of the file to which that symlink points.  I have not found a clean
solution for this yet, so until I do, I suggest one of the following work-arounds:

1. Delete the symlink (but not the file it references) from your `$HOME`
directory before running MDF.  Then, recreate it manually after you
restore, or add it to a bootstrap script somewhere.
2. Ensure that for all files in your dotfiles, the corresponding file
in `$HOME` is *not* a symlink.  Regular files will be unaffected.

### Design Considerations

One of the most important design goals of this project is to have as
few dependencies as possible.  Currently, the only things it depends
on are <del>`ruby`</del>, `bash`, and `git`.

### Supported Systems

For sure works:

- Darwin (Mac OS X)

Somewhat untested:

- Linux (Debian)

Will work eventually:

- SmartOS
- Linux (CentOS)

## Usage

### Configuring

To configure the installation and usage of `mdf`, there are three
environmental that can be set before installing.  The three variables
are:

1. `MDF_VAR_PATH`
2. `MDF_BIN_PATH`
3. `MDF_WORK_TREE`

`MDF_VAR_PATH` is where all of the files will be stored including the `profiles/`
directory, the `lib/` directory, and the `mdf` executable itself.  Upon
installation, a wrapper script will be written to `MDF_BIN_PATH` that sets the
above variables based on their values at the time of installation (or defaults
if they are unset) and passes the command line arguments along to the `mdf` script
in `MDF_VAR_PATH`.  

There are a couple of restrictions on what these variables can be set to.  Both
paths must be writable by the installing user, and files in the `MDF_BIN_PATH`
must be allowed to be executed.  In addition, whatever you choose as the 
`MDF_BIN_PATH` must be in your `$PATH` before installation.

The third variable, `MDF_WORK_TREE`, is the directory that
contains the files you intend to modify.  While this *can*
be changed, it is *strongly* recommended that it remain as
the default `$HOME`.

### Installing

```bash
git clone git@github.com:rafecolton/memory-dotfiles.git
cd memory-dotfiles
make install
```

### Uninstalling

```bash
# this will change at some point to be a bit safer
mdf uninstall
# ...or...
make uninstall
```

### Using

```bash
# print usage
mdf usage
mdf -h
mdf --help

# print version
mdf version
mdf --version

# list available profiles
mdf list

# use a selected profile
mdf use <profile>

# restore the original dotfiles
mdf restore
```

## Tests

To run tests:

```bash
./run-tests
# ...or...
make test
```

**NOTE:** The testing strategy and output format were borrowed from 
[modcloth-labs/mithril](https://github.com/modcloth-labs/mithril)
