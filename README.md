memory-dotfiles
===============

[![Build Status](https://travis-ci.org/rafecolton/memory-dotfiles.png?branch=master)]
(https://travis-ci.org/rafecolton/memory-dotfiles)

## About

### Making your dotfiles repo more accessible and less obtrusive
    
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

## Design Considerations

One of the most important design goals of this project is to have as
few dependencies as possible.  Currently, the only things it depends
on are `ruby`, `bash`, and `git`.

## Tests

To run tests:

```bash
./run-tests
```

**NOTE:** The testing strategy and output format were borrowed from 
[modcloth-labs/mithril](https://github.com/modcloth-labs/mithril)
