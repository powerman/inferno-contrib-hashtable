My attempt to implement polymorphic replacement for hash(2).

If Charles finally release [his version](http://article.gmane.org/gmane.os.inferno.general/2755/) one day, this project may become useless.

Dependencies:
  * http://code.google.com/p/inferno-contrib-tap/ (only for tests)
  * http://code.google.com/p/inferno-opt-mkfiles/


---


To install system-wide (if your Inferno installed in your home directory or if you root):

```
# mkdir -p $INFERNO_ROOT/opt/powerman/
# hg clone https://inferno-contrib-hashtable.googlecode.com/hg/ $INFERNO_ROOT/opt/powerman/hashtable
```

To install locally for some project:

```
$ cd $YOUR_PROJECT_DIR
$ mkdir -p opt/powerman/
$ hg clone https://inferno-contrib-hashtable.googlecode.com/hg/ opt/powerman/hashtable
$ emu
; cd $YOUR_PROJECT_DIR_INSIDE_EMU
; bind opt /opt
```

Using it in your application (this will allow you to compile your application using both host OS and native limbo without additional options if it was installed locally, but if you installed this module system-wide, you'll need to use `-I$INFERNO_ROOT` for host OS limbo and `-I/` for native limbo):

```
include "opt/powerman/hashtable/module/hashtable.m";
load HashTable HashTable->PATH;
```