implement HashTable_t;

include "sys.m";
	sys: Sys;
	sprint: import sys;
include "draw.m";
include "arg.m";
	arg: Arg;
include "../../module/hashtable.m";
	hashtable: HashTable;
	Hash: import hashtable;

HashTable_t: module
{
	init: fn(nil: ref Draw->Context, argv: list of string);
};

ERR, WARN, INFO, DEBUG, DUMP: con iota;
verbose := WARN;

init(nil: ref Draw->Context, argv: list of string)
{
	sys = load Sys Sys->PATH;
	arg = checkload(load Arg Arg->PATH, "Arg");
	hashtable = checkload(load HashTable HashTable->PATH, "HashTable");

	arg->init(argv);
	arg->setusage(sprint("%s [-v]", arg->progname()));
	while((p := arg->opt()) != 0)
		case p {
		'v' =>	verbose++;
		* =>	arg->usage();
		}
	argv = arg->argv();
	if(len argv != 0)
		arg->usage();


	hash := Hash[string].new(7);
	hash.set("key1", "value1");
	sys->print("%s = %s\n", "key1", hash.get("key1"));
	hash.set("key2", "value2");
	hash.set("key1", "value11");
	sys->print("%s = %s\n", "key1", hash.get("key1"));
	sys->print("%s = %s\n", "key2", hash.get("key2"));
	all := hash.all();
	for(l := all; l != nil; l = tl l)
		sys->print("all before del: %s = %s\n", (hd l).key, (hd l).val);
	hash.del("key1");
	all = hash.all();
	for(l = all; l != nil; l = tl l)
		sys->print("all after del: %s = %s\n", (hd l).key, (hd l).val);
	sys->print("%s = %q\n", "key1", hash.get("key1"));
	sys->print("%s = %q\n", "key2", hash.get("key2"));

	sys->print("done\n");
}




###

log(level: int, s: string)
{
	if(level > verbose)
		return;
	l : string;
	case level {
	ERR	=> l = "err";
	WARN	=> l = "warn";
	INFO	=> l = "info";
	DEBUG	=> l = "debug";
	DUMP	=> l = "dump";
	*	=> l = "unknown";
	}
	sys->fprint(sys->fildes(2), "%s: [%s] %s\n", arg->progname(), l, s);
}

fail(s: string)
{
	log(ERR, s);
	raise "fail:"+s;
}

checkload[T](x: T, s: string): T
{
	if(x == nil)
		fail(sprint("load: %s: %r", s));
	return x;
}

pidctl(pid: int, s: string): int
{
	f := sprint("#p/%d/ctl", pid);
	fd := sys->open(f, Sys->OWRITE);
	if(fd == nil || sys->fprint(fd, "%s", s) < 0){
		log(DEBUG, sprint("pidctl(%d, %s): %r", pid, s));
		return 0;
	}
	return 1;
}

readfile(f: string): array of byte
{
	fd := sys->open(f, Sys->OREAD);
	if(fd == nil){
		log(DEBUG, sprint("readfile(%q): %r", f));
		return nil;
	}
	return readfd(fd);
}

readfd(fd: ref Sys->FD): array of byte
{
	buf := array[0] of byte;
	d := array[Sys->ATOMICIO] of byte;
	for(;;){
		n := sys->read(fd, d, len d);
		if(n < 0){
			log(DEBUG, sprint("readfd: %r"));
			return nil;
		}
		if(n == 0)
			break;
		nbuf := array[len buf+n] of byte;
		nbuf[:] = buf;
		nbuf[len buf:] = d[:n];
		buf = nbuf;
	}
	return buf;
}


