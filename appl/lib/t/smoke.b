implement T;

include "opt/powerman/tap/module/t.m";
include "../../../module/hashtable.m";
	hashtable: HashTable;
	Hash, HashNode: import hashtable;

test()
{
	plan(8);

	hashtable = load HashTable HashTable->PATH;
	if(hashtable == nil)
		bail_out(sprint("load %s: %r",HashTable->PATH));

	hash := Hash[string].new(7);
	hash.set("key1", "value1");
	eq(hash.get("key1"), "value1",		"add key1");

	hash.set("key2", "value2");
	eq(hash.get("key2"), "value2",		"add key2");

	hash.set("key1", "value11");
	eq(hash.get("key1"), "value11",		"mod key1");
	eq(hash.get("key2"), "value2",		"  key2 unchanged");

	all := hash.all();
	lwait := ref HashNode[string]("key1","value11")	:: ref HashNode[string]("key2","value2") :: nil;
	eq_list(cmp_HashNode,all,lwait,		"all are: key1, key2");

	hash.del("key1");
	all = hash.all();
	lwait = ref HashNode[string]("key2","value2") :: nil;
	eq_list(cmp_HashNode,all,lwait,		"after del key1 all are: key2");

	eq(hash.get("key1"), nil,		"key1 is nil");
	eq(hash.get("key2"), "value2",		"key2=value2");
}

cmp_HashNode(a, b: ref HashNode[string]): int
{
	if(a.key < b.key)
		return -1;
	if(a.key > b.key)
		return 1;
	return 0;
}


