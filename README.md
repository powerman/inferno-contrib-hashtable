# Description

My attempt to implement polymorphic replacement for hash(2).

If Charles finally release [his
version](http://article.gmane.org/gmane.os.inferno.general/2755/) one day,
this project may become useless.


# Install

Make directory with this module available in /opt/powerman/hashtable/.

Install system-wide:

```
# git clone https://github.com/powerman/inferno-contrib-hashtable.git $INFERNO_ROOT/opt/powerman/hashtable
```

or in your home directory:

```
$ git clone https://github.com/powerman/inferno-contrib-hashtable.git $INFERNO_USER_HOME/opt/powerman/hashtable
$ emu
; bind opt /opt
```

or locally for your project:

```
$ git clone https://github.com/powerman/inferno-contrib-hashtable.git $YOUR_PROJECT_DIR/opt/powerman/hashtable
$ emu
; cd $YOUR_PROJECT_DIR_INSIDE_EMU
; bind opt /opt
```

If you want to run commands and read man pages without entering full path
to them (like `/opt/VENDOR/APP/dis/cmd/NAME`) you should also install and
use https://github.com/powerman/inferno-opt-setup 

## Dependencies

* https://github.com/powerman/inferno-contrib-tap (only for tests)
* https://github.com/powerman/inferno-opt-mkfiles


# Usage

Such include path will let you compile your application using both host OS
and native limbo without additional options if this module was installed
locally in your project, but if you installed this module system-wide,
then you'll need to use `-I$INFERNO_ROOT` for host OS limbo and `-I/` for
native limbo.

```
include "opt/powerman/hashtable/module/hashtable.m";
load HashTable HashTable->PATH;
```

