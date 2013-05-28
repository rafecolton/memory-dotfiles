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

### Design Considerations

One of the most important design goals of this project is to have as
few dependencies as possible.  Currently, the only things it depends
on are `ruby`, `bash`, and `git`.

## Usage

### Configuring

To configure the installation and usafe of `mdf`, edit the `.example.env`
file and source it before installing.  There are three environmental
variables that the installation script depends on:

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
contains the files you tend to modify.  While this *can* be changed, it is *strongly*
recommended that it remain as the default `$HOME`.

### Installing

```bash
git clone git@github.com:rafecolton/memory-dotfiles.git
# edit .example.env if you wish
source .example.env
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

# list available profiles
mdf list

# use a selected profile
# currently unimplemented
mdf use <profile>

# restore the original dotfiles
# currently unimplemented
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
