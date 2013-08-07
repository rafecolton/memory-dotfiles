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

### Disclaimers

1. Use with caution.  This is still a WIP, so using it may
screw some things up in your `$HOME` directory.
2. If you screw something up and cannot fix it, submit a GitHub Issue and I will
do my best to help you fix it.
3. Also, you may need to manually add private things like an updated `.git-authors`
file and `ssh` keys.

### Design Considerations

One of the most important design goals of this project is to have as
few dependencies as possible.  Currently, the only things it depends
on are <del>`ruby`</del>, `bash`, and `git`.

### Supported Systems

For sure works:

- Darwin (Mac OS X)

Slightly broken but will work soon:

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
./script/install
```

### Uninstalling

```bash
# to uninstall normally
mdf uninstall

# to restore and uninstall
mdf uninstall -c
mdf uninstall --clean
```

### Using

```
Usage: mdf <comand> [options]

Command list:
<usage | --help | -h>   : display this message
<add>                   : add a new profile
<list>                  : list available profiles
<restore>               : restore working tree to original state
<uninstall>             : uninstall mdf entirely
<use>                   : deploy a selected dotfile set
<version | --verison>   : print version number and exit

You can also type `mdf help <command>` to learn more about a particular command.

Happy coding!
```

## Tests

To run tests:

```bash
./run-tests
```

## TODO

- Add updating for installed repo as well as current dotfile set
- Add 'remove' command for deleting dotfile sets
- Add 'add' command (done but still needs tests)
- Make tests safer by with a fake home directory
- **Something is really broken with `use` and `restore` - figure it out!**

**NOTE:** The testing strategy and output format were borrowed from 
[modcloth-labs/mithril](https://github.com/modcloth-labs/mithril)
